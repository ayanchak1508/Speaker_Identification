path = "DSP_Recordings";
name = "Swarnava";
time = "morn";
index = "2";
Fs_final = 8000;
windowLength = round(0.03*Fs_final);
overlapLength = round(0.025*Fs_final);

new_path = strcat(path,"/",name,"/",time+index,".wav");
[y_test, ~] = audioread(new_path);
sound(y_test)

voicedSpeech = isVoicedSpeech(y_test, Fs_final, windowLength, overlapLength);
y_test = (y_test./max(abs(y_test)))*ampMax;
melC_test = mfcc(y_test, Fs_final, 'OverlapLength', overlapLength, 'WindowLength', windowLength);
f0_test = pitch(y_test, Fs_final, 'WindowLength', windowLength, 'OverlapLength', overlapLength);
feat_test = [melC_test,f0_test];
feat_test(~voicedSpeech,:) = [];

M = mean(feat_test,1);
S = std(feat_test,[],1);
feat_test = (feat_test-M)./S;

class = predict(trainedClassifier,feat_test);
class = convertCharsToStrings(class);

nums = [];
for name = ["Ayan", "Jaanesh", "Nivedita", "Prerna", "Rudrajyoti", "Swarnava"]
    temp = sum(ismember(class, name));
    nums = [nums; temp];
end

name = ["Ayan"; "Jaanesh"; "Nivedita"; "Prerna"; "Rudrajyoti"; "Swarnava"];
nums = nums./sum(nums);
nums(nums<0.5) = 0;
nums(nums>=0.5) = 1;

if(~any(nums(:)))
    disp("Unauthorised Access")
else
    final_class = name(nums==1);
    disp(final_class);
end
%% 
%[y_test, ~] = audioread(new_path);
frameDuration = 0.22;
hopDuration = 0.01;
frameLength = round(frameDuration*Fs_final);
hopLength = round(hopDuration*Fs_final);
stride = 2200;
numHops = ceil((segmentDuration - frameDuration)/hopDuration);
windowLen = 8192;
numBands = 40;
X = zeros(numBands,numHops);
[yupper, ylower] = envelope(y_test);
y_test((yupper-ylower)<0.1) = [];

preds = [];
i = 0;
go = true;
while(go)
    lower_bound = i*stride + 1;
    upper_bound = min(lower_bound + windowLen - 1, length(y_test));
    sample = y_test(lower_bound : upper_bound);
    sample = normalizeAndResize(sample);
    spec = melSpectrogram(sample,Fs_final, ...
        'WindowLength',frameLength, ...
        'OverlapLength',(frameLength - hopLength), ...
        'FFTLength',2048, ...
        'NumBands',numBands, ...
        'FrequencyRange',[50,4000]);
    w = size(spec,2);
    left = floor((numHops-w)/2)+1;
    ind = left:left+w-1;
    X(:,ind) = spec;
    X = log10(X + epsil);
    [Ypredicted,probs] = classify(trainedNet,X,'ExecutionEnvironment','CPU');
    preds = [preds, Ypredicted];
    
    i = i + 1;
    if(upper_bound == length(y_test))
        go = false;
    end
end