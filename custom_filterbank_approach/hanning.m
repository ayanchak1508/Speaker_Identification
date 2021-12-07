function w = hanning(N)
%HANNING Summary of this function goes here
%   Detailed explanation goes here
 for i=0:N-1
     w(i+1,1)=0.5 - 0.5*cos(2*pi*i/(N-1));
 end
end

