function w = blackmann(N)
%BLACKMANN Summary of this function goes here
%   Detailed explanation goes here
 for i=0:N-1
     w(i+1,1)= 0.42 - 0.5*cos(2*pi*i/(N-1)) + 0.08*cos(4*pi*i/(N-1));
 end
end

