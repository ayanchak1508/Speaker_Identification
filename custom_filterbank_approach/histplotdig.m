clc
clear
filename1 = 'Shouvik\Shouvik_non1000.csv';
filename2 = 'Rudrajyoti\Rudrajyoti_non1000.csv';
filename3 = 'Prerna\Prerna_non1000.csv';
filename4 = 'Nivedita\Nivedita_non1000.csv';
filename5 = 'Swarnava\Swarnava_non1000.csv';
filename6 = 'Jaanesh\Jaanesh_non1000.csv';
filename7 = 'Ayan\Ayan_non1000.csv';
A1 = csvread(filename1);
A2 = csvread(filename2);
A3 = csvread(filename3);
A4 = csvread(filename4);
A5 = csvread(filename5);
A6 = csvread(filename6);
A7 = csvread(filename7);
dx = A7;
band = dx(:,1);
du = [dx(:,2),dx(:,3),dx(:,4),dx(:,5),dx(:,6),dx(:,7),dx(:,8),dx(:,9),dx(:,10)];

% Single User 8 samples comparsion
strinval = ["Morning Day 1","Morning Day 2","Morning Day 3","Morning Day 4","Afternoon Day 1","Afternoon Day 2","Afternoon Day 3","Afternoon Day 4","Average"];

    figure(1)
    plot(du(:,1),band,"r",band,du(:,2),"y",band,du(:,3),"b",band,du(:,4),"g",band,du(:,5),"r--",band,du(:,6),"y--",band,du(:,7),"b--",band,du(:,8),"g--",band,du(:,9),"black");
    legend(strinval);
    title(" Ayan - Blackmann window with 100 Uniform Bands ");
    xlabel("Frequency (in Hz)");
    ylabel("Energy");

% All Speaker Comparison
% dx = [A1(:,10),A2(:,10),A3(:,10),A4(:,10),A5(:,10),A6(:,10),A7(:,10)];
% band = A1(:,1);
% name = ["Shouvik","Rudrajyoti","Prerna","Nivedita","Swarnava","Jaanesh","Ayan"];
% figure(1)
% plot(band,0.125*dx(:,1),"r",band,0.125*dx(:,2),"b",band,0.125*dx(:,3),"g",band,0.125*dx(:,4),"y",band,dx(:,5),"black",band,dx(:,6),"r*",band,dx(:,7),"b*");
% legend(name);
% title(" Average of all people using blckmann Window with 1000 non-uniform bands");
% xlabel("Frequency (in Hz)");
% ylabel("Energy");


% Window Comparison Plot
% name = "Ayan";
% filename1 = 'D:\Project\MATLAB\DSP\groupassg2\'+name+'\'+name+'_uni1000.csv';
% filename2 = 'D:\Project\MATLAB\DSP\groupassg2\'+name+'\'+name+'_uni1000hann.csv';
% filename3 = 'D:\Project\MATLAB\DSP\groupassg2\'+name+'\'+name+'_uni1000hamm.csv';
% A1 = csvread(filename1);
% A2 = csvread(filename2);
% A3 = csvread(filename3);
% dx = [A1(:,10),A2(:,10),A3(:,10)];
% band = A1(:,1);
% namep = ["Blackmann","Hanning","Hamming"];
% figure(1)
% plot(band,dx(:,1),"r",band,dx(:,2),"b",band,dx(:,3),"g");
% legend(namep);
% title(" Window Comparsion of "+name);
% xlabel("Frequency (in Hz)");
% ylabel("Energy");