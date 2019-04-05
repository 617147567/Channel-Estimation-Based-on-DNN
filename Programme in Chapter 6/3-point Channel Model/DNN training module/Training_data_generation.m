 function d = Training_data_generation()  
 


L=3;
SNR=10;


P=[1+1i,1-1i,2-1i,1+2i]';


for i=1:1000000
hh=randn(3,1)+1i*randn(3,1);
yy=comsystem(P,L,hh,SNR);

h(:,i)=hh;
y(:,i)=yy;
end



save h.mat h;
save y.mat y;