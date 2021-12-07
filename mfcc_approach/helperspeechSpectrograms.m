function X = helperspeechSpectrograms(ads,segmentDuration,frameDuration,hopDuration,numBands)
disp("Computing speech spectrograms...");

numHops = ceil((segmentDuration - frameDuration)/hopDuration);
numFiles = length(ads.Files);
X = zeros([numBands,numHops,1,numFiles],'single');
% X = zeros(numBands,numHops,1,numFiles);

for i = 1:numFiles
    
    [x,info] = read(ads);
    x = normalizeAndResize(x);
    fs = info.SampleRate;
    %fs = 8000;
    frameLength = round(frameDuration*fs);
    hopLength = round(hopDuration*fs);
    
    %disp(frameLength)
    %disp(frameLength-hopLength)
    
    spec = melSpectrogram(x,fs, ...
        'WindowLength',frameLength, ...
        'OverlapLength',(frameLength - hopLength), ...
        'FFTLength',2048, ...
        'NumBands',numBands, ...
        'FrequencyRange',[50,4000]);
    
    w = size(spec,2);
    left = floor((numHops-w)/2)+1;
    ind = left:left+w-1;
    X(:,ind,1,i) = spec;
    
    if mod(i,500) == 0
        disp("Processed " + i + " files out of " + numFiles)
    end
    
end

disp("...done");

end