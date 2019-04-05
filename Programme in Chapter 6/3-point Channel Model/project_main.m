clear all;
clc;

L=3;


P=[1+1i,1-1i,2-1i,1+2i]';

for SNR=1:10

for u=1:2000


H=randn(3,1)+1i*randn(3,1);

Y=comsystem(P,L,H,SNR);




h_estls=ls(Y,P,L);


h_estDNN=DNN_est(Y,SNR);   % get DNNestimate




var_ls(u)=mean(abs(h_estls-H).^2); % calculate MSE
var_DNN(u)= mean(abs(h_estDNN-H).^2)/3; % calculate MSE


end


mean_var_ls(SNR) = mean(var_ls); 
mean_var_DNN(SNR)=mean(var_DNN);




end

%%


t=1:10; % for plot
% t=1;
semilogy(t,mean_var_ls,'r-o');               
hold on
semilogy(t,mean_var_DNN,'b-o');
hold on

xlabel('SNR(dB)');
ylabel('MSE(Mean Square Error)');
legend('Least Square estimate','DNN estimate');
title('Comparison of Mean Square Error');
