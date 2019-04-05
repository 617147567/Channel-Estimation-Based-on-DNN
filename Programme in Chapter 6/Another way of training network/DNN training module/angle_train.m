clc
clear all
close all

load y
load h

n = size(y,2);
indim = size(y,1);
outdim = size(h,1);



inputdim = indim;
outputdim = outdim;

%% Take y as input
abs_y = abs(y);
angle_y = angle(y);


yy = zeros(inputdim,n);

yy=angle(y);


%% Take h as output
abs_h = abs(h);
angle_h = angle(h);


hh = zeros(outputdim,n);

hh=angle(h);


%% Data Normalizaiton
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
hiden = 8;

net = newff(pr,[hiden,outputdim],{'logsig','purelin'},'trainlm');
net.trainParam.lr=0.001;
net.trainParam.goal=1e-5;
net.trainParam.epochs=125;
net=train(net,trainYY,trainHH);


save angle_SNR10.mat net lowvecinput upvecinput lowvecoutput upvecoutput
% save yy.mat yy;
% save hh.mat hh;
