%%
clc
clear
nband = csvread("Nivedita/Nivedita_uni100.csv");
pband = csvread("Prerna/Prerna_uni100.csv");
rband = csvread("Rudrajyoti/Rudrajyoti_uni100.csv");
sband = csvread("Shouvik/Shouvik_uni100.csv");
swband = csvread("Swarnava/Swarnava_uni100.csv");
jband = csvread("Jaanesh/Jaanesh_uni100.csv");
aband = csvread("Ayan/Ayan_uni100.csv");
features = [nband(:,2:9),pband(:,2:9),rband(:,2:9),sband(:,2:9),swband(:,2:9),jband(:,2:9),aband(:,2:9)];
meanfeat = mean(features,1);
stdfeat = std(features,[],1);
features = (features - meanfeat)./stdfeat ; 
nband(:,10) = 0.125*nband(:,10);
pband(:,10) = 0.125*pband(:,10);
rband(:,10) = 0.125*rband(:,10);
sband(:,10) = 0.125*sband(:,10);
%%
label = [];
for i=1:length(features)
    if(i<9)
        label = [label,"Nivedita"];
    elseif (i>=9 && i<17)
        label = [label,"Prerna"];
    elseif (i>=17 && i<25)
        label = [label,"Rudrajyoti"];
    elseif (i>=25 && i<33)
        label = [label,"Shouvik"];
    elseif (i>=33 && i<41)
        label = [label,"Swarnava"];
    elseif (i>=41 && i<49)
        label = [label,"Jaanesh"];
    elseif (i>=49 && i<57)
        label = [label,"Ayan"];
    end
end
%%
features = features' ; 
label = (cellstr(label))';
%%
trainedClassifier = fitcknn(...
    features, ...
    label, ...
    'Distance','cityblock', ...
    'NumNeighbors',1, ...
    'DistanceWeight','equal', ...
    'Standardize',false, ...
    'ClassNames',unique(label));
%%
predictedY = resubPredict(trainedClassifier);
cm = confusionchart(label,predictedY);

%%
k = 4;
group = label;
c = cvpartition(group,'KFold',k); % k-fold stratified cross validation
partitionedModel = crossval(trainedClassifier,'CVPartition',c);
%%
validationAccuracy = 1 - kfoldLoss(partitionedModel,'LossFun','ClassifError');
fprintf('\nValidation accuracy = %.2f%%\n', validationAccuracy*100);
%%
validationPredictions = kfoldPredict(partitionedModel);
figure
cm = confusionchart(label,validationPredictions,'title','Validation Accuracy');
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';
%%
% testcase = [nband(:,10),pband(:,10),rband(:,10),sband(:,10),swband(:,10),jband(:,10),aband(:,10)];
% meantest = mean(testcase,1);
% stdtest = std(testcase,[],1);
% testcase = (testcase-meantest)./stdtest;
filename= 'D:\Project\MATLAB\DSP\groupassg2\Jaanesh\test.wav';
[y1,Fs1] = audioread(filename);
N1 = length(y1);
band = [(linspace(0,4000,101)')];
bandenergy(:,1) = filterbankreal(band,Fs1,y1,N1,@blackmann);
testcase = bandenergy;
meantest = mean(testcase,1);
stdtest = std(testcase,[],1);
testcase = (testcase-meantest)./stdtest;
%%
% testlabel = [];
% for i=1:length(features)
%     if(i<3)
%         testlabel = [testlabel,"Nivedita"];
%     elseif (i>=3 && i<5)
%         testlabel = [testlabel,"Prerna"];
%     elseif (i>=5 && i<7)
%         testlabel = [testlabel,"Rudrajyoti"];
%     elseif (i>=7 && i<9)
%         testlabel = [testlabel,"Shouvik"];
%     elseif (i>=9 && i<11)
%         testlabel = [testlabel,"Swarnava"];
%     end
% end
% testlabel = ["Nivedita","Prerna","Rudrajyoti","Shouvik","Swarnava","Jaanesh","Ayan"];
 testlabel = ["Jaanesh"];
%%
testcase =testcase';
testlabel = (cellstr(testlabel))';
%%
prediction = predict(trainedClassifier,testcase);
prediction = categorical(string(prediction));
%%
figure('Units','normalized','Position',[0.4 0.4 0.4 0.4])
cm = confusionchart(categorical(testlabel),prediction,'title','Test Accuracy (Per Frame)');
cm.ColumnSummary = 'column-normalized';
cm.RowSummary = 'row-normalized';