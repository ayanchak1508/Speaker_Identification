function [z] = filterbankreal(band,Fs,x,N,ch)
%FILTERBANK Summary of this function goes here
%   Detailed explanation goes here
z = zeros(length(band)-1,1);
N1 = 39;
ysig = zeros(N1+N-1,1);
zsig = zeros(2*N1+N-2,1);
 for i=1:length(band)-1
     if(band(i,1)==0)
         wc = band(i+1)*2*pi/Fs;
         b = ideallowpass(N1,wc,ch);
         ysig(:,1)= conv(b,x);
         energy = sum(ysig.^2);
         z(i) = energy;
     end
     if(band(i,1)~=0)
         wc = band(i+1)*2*pi/Fs;
         wb = band(i)*2*pi/Fs;
         b = idealbandpass(N1,wc,wb,ch);
         zsig(:,1)= conv(b,x);
         energy = sum(zsig.^2);
         z(i) = energy;
     end
%      figure(i)
%      freqz(b)
     
 end
end

