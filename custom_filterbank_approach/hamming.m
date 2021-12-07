function w = hamming(N)
%HAMMING Summary of this function goes here
%   Detailed explanation goes here
 for i=0:N-1
     w(i+1,1) = 0.54 - 0.46*cos(2*pi*i/(N-1));
 end
end

