function hd = ideallowpass(N,wc,ch)
  hd = zeros(N,1);
  k = (N-1)/2;
  for i = 0:N-1
      if(i==k)
          hd(i+1)=wc/pi;
      else
          hd(i+1) = (sin(wc*(i-k)))/(pi*(i-k));
      end
  end
  hd = hd.*ch(N);
end