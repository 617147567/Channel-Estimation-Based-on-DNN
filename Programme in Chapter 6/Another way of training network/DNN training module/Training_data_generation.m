 function d = Training_data_generation()  
 
 

SNR=10;


 p=[1+1i,1-1i,2-1i,1+2i]';

for u=1:1000000
   h(u)=randn(1)+randn(1)*1i; 
end

y=awgn(p*h,SNR,'measured');


save y.mat y;
save h.mat h;