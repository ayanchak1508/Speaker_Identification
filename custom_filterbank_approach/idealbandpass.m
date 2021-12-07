function hd = idealbandpass(N,wc,wb,ch)
  dl = zeros(N,1);
  dh = zeros(N,1);
  k = (N-1)/2;
  n = 0:N-1;
  for i = 0:N-1
      if(i==k)
          dl(i+1)=wc/pi;
      else
          dl(i+1) = (sin(wc*(i-k)))/(pi*(i-k));
      end
  end
  dl = dl.*ch(N);
  for i=0:N-1
      if(i==k)
          dh(i+1)=1-wb/pi;
      else
          dh(i+1) = -(sin(wb*(i-k)))/(pi*(i-k));
      end
  end
  dh = dh.*ch(N);
  hd = conv(dl,dh);
end