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


% h_estls=ls(y,pilot);   % get ls estimate result
h_estDNN=DNN_est(y,SNR);   % get DNNestimate

abs_h=abs_est(y,SNR);
angle_h=angle_est(y,SNR);
h_estDNN2=abs_h*exp(1i*angle_h);
h_estDNN3=DNN2_est(y,SNR);




% var_ls(u)= 0.5 * ((real(h_estls)-real(h))^2+(imag(h_estls)-imag(h))^2);
% % calculate MSE 
% var_DNN(u)=0.5 * ((real(h_estDNN)-real(h))^2+(imag(h_estDNN)-imag(h))^2);   % calculate MSE

% var_ls(u)= abs(h_estls-h)^2/abs(h);   % calculate MSE
var_DNN(u)=(real(h_estDNN)-real(h))^2+(imag(h_estDNN)-imag(h))^2; % calculate MSE
var_DNN2(u)=(real(h_estDNN2)-real(h))^2+(imag(h_estDNN2)-imag(h))^2;
var_DNN3(u)=(real(h_estDNN3)-real(h))^2+(imag(h_estDNN3)-imag(h))^2;


end


% mean_var_ls(SNR) = mean(var_ls); 
 mean_var_DNN(SNR)=mean(var_DNN);
mean_var_DNN2(SNR)=mean(var_DNN2);
mean_var_DNN3(SNR)=mean(var_DNN3);





end

%%
t=1:10; % for plot
% semilogy(t,mean_var_ls,'r-o');               
% hold on
plot(t,mean_var_DNN,'b-o');
hold on
plot(t,mean_var_DNN2,'g-*');
hold on
plot(t,mean_var_DNN3,'r-o');
hold on

xlabel('SNR(dB)');
ylabel('MSE(Mean Square Error)');
% legend('Least Square estimate','DNN estimate','DNN2 estimate');
legend('Solution in Section 4.2.1','Solution 1','Solution 2');
title('Comparison of Mean Square Error');
