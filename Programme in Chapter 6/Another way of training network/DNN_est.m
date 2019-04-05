function h_estDNN=DNN_est(y,SNR)

switch SNR
    case{1}
        load network_SNR1;
    case{2}
        load network_SNR2;
    case{3}
        load network_SNR3;
    case{4}
        load network_SNR4;
    case{5}
        load network_SNR5;
    case{6}
        load network_SNR6;
    case{7}
        load network_SNR7;
    case{8}
        load network_SNR8;
    case{9}
        load network_SNR9;
    case{10}
        load network_SNR10;

 
end
    




indim = size(y,1);

inputdim = indim*2;


testy = y;
realy = real(testy);
imagy = imag(testy);

yy = zeros(inputdim,1);

yy(1:2:inputdim-1,:) = realy;
yy(2:2:inputdim,:) = imagy;


testYY = yy;
testYY = (testYY-lowvecinput)./(upvecinput-lowvecinput);


simHH = sim(net,testYY);




thh = simHH;
thh = thh.*(upvecoutput-lowvecoutput) + lowvecoutput;


h_estDNN=thh(1)+thh(2)*1i;
 end

