function h_estDNN2=DNN2_est(y,SNR)

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
    

indim = size(y,1);

inputdim = indim*2;

testy = y;
abs_y = abs(testy);
angle_y = angle(testy);

yy = zeros(inputdim,1);

yy(1:2:inputdim-1,:) = abs_y;
yy(2:2:inputdim,:) = angle_y;


testYY = yy;
testYY = (testYY-lowvecinput)./(upvecinput-lowvecinput);



simHH = sim(net,testYY);


thh = simHH;
thh = thh.*(upvecoutput-lowvecoutput) + lowvecoutput;


h_estDNN2=thh(1)*exp(1i*thh(2));
 end

