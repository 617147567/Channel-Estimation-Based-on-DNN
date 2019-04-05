clear all;
clc;

% L=1; % taps of channel 

pilot=[1+1i,1-1i,2-1i,1+2i]';




for SNR=1:10


for u=1:2000


h= randn(1)+randn(1)*1i;   % random channel coefficient

w=pilot*h;
y=awgn(w,SNR,'measured');
% y=comsystem(s,h,SNR); 


h_estls=ls(y,pilot);   % get ls estimate result
h_estDNN=DNN_est(y,SNR);   % get DNNestimate



var_ls(u)= abs(h_estls-h)^2/abs(h);   % calculate MSE
var_DNN(u)=abs(h_estDNN-h)^2/abs(h);  % calculate MSE

% var_ls(u)= mse(h_estls-h);   % calculate MSE
% var_DNN(u)=mse(h_estDNN-h)^2/abs(h); 

end


mean_var_ls(SNR) = mean(var_ls); 
mean_var_DNN(SNR)=mean(var_DNN);




end

%%
t=1:10; % for plot
semilogy(t,mean_var_ls,'r-o');               
hold on
semilogy(t,mean_var_DNN,'b-o');
hold on

xlabel('SNR(dB)');
ylabel('MSE(Mean Square Error)');
legend('Least Square estimate','DNN estimate');
title('Comparison of Mean Square Error');
