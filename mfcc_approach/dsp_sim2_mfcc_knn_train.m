path = "DSP_Recordings";
ampMax = 0.5;
Fs_final = 8000;
windowLength = round(0.03*Fs_final);
overlapLength = round(0.025*Fs_final);
features = [];
labels = [];

for name = ["Ayan", "Jaanesh", "Nivedita", "Prerna", "Rudrajyoti", "Swarnava", "Shouvik"]
    for time = ["afti", "morn"]
        for index = ["1", "2", "3", "4"]
            new_path = strcat(path,"/",name,"/",time+index,".wav");
            [y, ~] = audioread(new_path);
            voicedSpeech = isVoicedSpeech(y, Fs_final, windowLength, overlapLength);
            y = (y./max(abs(y)))*ampMax;
            melC = mfcc(y, Fs_final, 'OverlapLength', overlapLength, 'WindowLength', windowLength);
            f0 = pitch(y, Fs_final, 'WindowLength', windowLength, 'OverlapLength', overlapLength);
            feat = [melC,f0];
            feat(~voicedSpeech,:) = [];
            features = [features; feat];
            label = repelem(name,size(feat,1));
            labels = [labels, label];
        end
    end
end

labels = convertStringsToChars(labels);

%% 
M = mean(features,1);
S = std(features,[],1);
features = (features-M)./S;
%% 
trainedClassifier = fitcknn( ...
    features, ...
    labels, ...
    'Distance','cityblock', ...
    'NumNeighbors',3, ...
    'DistanceWeight','squaredinverse', ...
    'Standardize',false, ...
    'ClassNames',unique(labels));
%% 
k = 5;
group = labels;
c = cvpartition(group,'KFold',k); % 5-fold stratified cross validation
partitionedModel = crossval(trainedClassifier,'CVPartition',c);

validationAccuracy = 1 - kfoldLoss(partitionedModel,'LossFun','ClassifError');
fprintf('\nValidation accuracy = %.2f%%\n', validationAccuracy*100);

validationPredictions = kfoldPredict(partitionedModel);
figure
cm = confusionchart(labels,validationPredictions,'title','Validation Accuracy');
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';