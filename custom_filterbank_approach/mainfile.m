clc
clear
name = ["Shouvik","Rudrajyoti","Nivedita","Prerna","Swarnava","Jaanesh","Ayan"];
filename1 = name(1,6)+'\Morning_1.wav';
filename2 = name(1,6)+'\Morning_2.wav';
filename3 = name(1,6)+'\Morning_3.wav';
filename4 = name(1,6)+'\Morning_4.wav';
filename5 = name(1,6)+'\Aftlnch_1.wav';
filename6 = name(1,6)+'\Aftlnch_2.wav';
filename7 = name(1,6)+'\Aftlnch_3.wav';
filename8 = name(1,6)+'\Aftlnch_4.wav';
[y1,Fs1] = audioread(filename1);
[y2,Fs2] = audioread(filename2);
[y3,Fs3] = audioread(filename3);
[y4,Fs4] = audioread(filename4);
[y5,Fs5] = audioread(filename5);
[y6,Fs6] = audioread(filename6);
[y7,Fs7] = audioread(filename7);
[y8,Fs8] = audioread(filename8);
%sound(y,Fs1);
N1 = length(y1);
N2 = length(y2);
N3 = length(y3);
N4 = length(y4);
N5 = length(y5);
N6 = length(y6);
N7 = length(y7);
N8 = length(y8);

% Normal 0-4000 1000 band 100 band 10 bands taken 
% Non unifor 0-1000 1000/100/10 bands 1000-4000 1000/100/10 bands
% Highly non_uniform 0-100 100 band 100-800 1000 bands 800-4000 100 bands
% Used for creation of non uniform bands
% count1 = 10;
% count2 = 10;
% band = [(linspace(0,1000,count1 +1)');(linspace(1000,4000,count2+1 )')];
% finalband = [(linspace(0,1000,count1+1)');(linspace(1000,4000,count2)')];
% Used for creation of Uniform Bands
count = 1000;
band = [(linspace(0,4000,count +1)')];
finalband = [(linspace(0,4000,count)')];
bandenergy = zeros(length(band)-1,8);
avgenergy = zeros(length(band)-1,1);
% The last parameter can be used to change the window function
% hanning,hamming,blackmann are available
bandenergy(:,1) = filterbankreal(band,Fs1,y1,N1,@hanning);
bandenergy(:,2) = filterbankreal(band,Fs2,y2,N2,@hanning);
bandenergy(:,3) = filterbankreal(band,Fs3,y3,N3,@hanning);
bandenergy(:,4) = filterbankreal(band,Fs4,y4,N4,@hanning);
bandenergy(:,5) = filterbankreal(band,Fs5,y5,N5,@hanning);
bandenergy(:,6) = filterbankreal(band,Fs6,y6,N6,@hanning);
bandenergy(:,7) = filterbankreal(band,Fs7,y7,N7,@hanning);
bandenergy(:,8) = filterbankreal(band,Fs8,y8,N8,@hanning);
avgenergy(:,1) = 0.125*sum(bandenergy,2);
finalmatrix = [finalband,bandenergy,avgenergy];

writematrix(finalmatrix,name(1,6)+"\"+name(1,6)+"_uni1000hann.csv");















