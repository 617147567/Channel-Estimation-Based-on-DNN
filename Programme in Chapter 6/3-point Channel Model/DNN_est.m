function h_estDNN=DNN_est(Y,SNR)

switch SNR
    case{1}
        load DNN_SNR1;
    case{2}
        load DNN_SNR2;
    case{3}
        load DNN_SNR3;
    case{4}
        load DNN_SNR4;
    case{5}
        load DNN_SNR5;
     case{6}
        load DNN_SNR6;
    case{7}
        load DNN_SNR7;
    case{8}
        load DNN_SNR8;
     case{9}
        load DNN_SNR9;
     case{10}
        load DNN_SNR10;
 
end
    


n = size(Y,2);
indim = size(Y,1);

inputdim = indim*2;


%% take y as input
testy = Y;
realy = real(testy);
imagy = imag(testy);

yy = zeros(inputdim,1);

yy(1:2:inputdim-1,:) = realy;
yy(2:2:inputdim,:) = imagy;

%% normalization

testYY = yy;
testYY = (testYY-lowvecinput)./(upvecinput-lowvecinput);



simHH = sim(net,testYY);



thh = simHH;
thh = thh.*(upvecoutput-lowvecoutput) + lowvecoutput;



h_estDNN=[thh(1)+1i*thh(2);thh(3)+1i*thh(4);thh(5)+1i*thh(6)];
end

