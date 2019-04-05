clear all
clc;

for i=1:2000

h=randn(1)+randn(1)*1i;    %random channel coefficient
bit_length=2000;% bit length of transmitted signal


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------TRANSMITTED MESSAGE and PILOT SIGNAL-----------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% p=[1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i,1+2i,1+1i,1-1i,2-1i,1+2i,1+1i,1-1i,2-1i,1+2i]';
% random 64 pilot signal

p=[1+1i,1-1i,2-1i,1+2i]'; %random 8 pilot signal

for u=1:bit_length
transmitted_message(u)=randi([0 1]);
end             % generate random transmitted binary message


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------16QAM Modulation---------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tx=modqpsk(transmitted_message);  
tx=qammod(transmitted_message,16);


for SNR=1:10
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------------CHANNEL MODEL----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 received_pilot=awgn(p*h,SNR,'measured');    
 received_symbol=awgn(tx*h,SNR,'measured');      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------------LS ESTIMATION----------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_estls=(p'*p)\(p'*received_pilot);   % ls estimate
h_estDNN=DNN_est(received_pilot,SNR);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%---------------------------LS EQULIZATION---------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


rx=(h_estls'*h_estls)\(h_estls'*received_symbol);
rx2=(h_estDNN'*h_estDNN)\(h_estDNN'*received_symbol);
% rx3=(h'*h)\(h'*received_symbol);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------------------16QAM Deodulation--------------------------%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% received_message_ls= demodqpsk(rx);
% received_message_DNN=demodqpsk(rx2);

received_message_ls=qamdemod(rx,16);
received_message_DNN=qamdemod(rx2,16);
% received_message_perfectCIR=qamdemod(rx3,64);



errornumber=length(nonzeros(received_message_ls-transmitted_message));
errornumber2=length(nonzeros(received_message_DNN-transmitted_message));
% errornumber3=length(nonzeros(received_message_perfectCIR-transmitted_message));

BER_ls(i,SNR)=errornumber/bit_length;
BER_DNN(i,SNR)=errornumber2/bit_length;
% BER_PerfectCIR(i,SNR)=errornumber3/bit_length;
end

mean_BERls=mean(BER_ls);
mean_BERDNN=mean(BER_DNN);
% mean_BERperfectCIR=mean(BER_PerfectCIR);
end
%% plot block
 t = 1:10;

 semilogy(t,mean_BERls,'r-o');
 hold on
 semilogy(t,mean_BERDNN,'b-+');
 hold on
%  semilogy(t,mean_BERperfectCIR,'b-*');
 xlabel('SNR');
 ylabel('BER(Bit Error Rate)');
 legend('LS estimate','DNN estimate','Perfect CIR');
 title('Compare BER');

