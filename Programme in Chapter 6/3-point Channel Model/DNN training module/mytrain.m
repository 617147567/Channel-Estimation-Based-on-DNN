clc
clear all
close all

load y
load h

n = size(y,2);
indim = size(y,1);
outdim = size(h,1);

inputdim = indim*2;
outputdim = outdim*2;

%% Take y as input
realy = real(y);
imagy = imag(y);

yy = zeros(inputdim,n);

yy(1:2:inputdim-1,:) = realy;
yy(2:2:inputdim,:) = imagy;

%% Take h as output
realh = real(h);
imagh = imag(h);

hh = zeros(outputdim,n);

hh(1:2:outputdim-1,:) = realh;
hh(2:2:outputdim,:) = imagh;

%% Data Normalization before training
lowvecinput = min(yy')';
upvecinput = max(yy')';

trainYY = yy;
for i = 1:n
    tmp = yy(:,i);
    tmp = (tmp-lowvecinput)./(upvecinput-lowvecinput);
    trainYY(:,i) = tmp;
end

lowvecoutput = min(hh')';
upvecoutput = max(hh')';

trainHH = hh;
for i = 1:n
    tmp = hh(:,i);
    tmp = (tmp-lowvecoutput)./(upvecoutput-lowvecoutput);
    trainHH(:,i) = tmp;
end


pr = zeros(inputdim,2);
pr(:,1) = 0;
pr(:,2) = 1;
hiden = 18;



net = newff(pr,[hiden,outputdim],{'logsig','purelin'},'trainlm');
net.trainParam.lr=0.01;
net.trainParam.goal=1e-5;
net.trainParam.epochs=40;
net=train(net,trainYY,trainHH);
disp('Training Complete')

%% save network
save DNN_SNR10.mat net lowvecinput upvecinput lowvecoutput upvecoutput
% save yy.mat yy;
% save hh.mat hh;
