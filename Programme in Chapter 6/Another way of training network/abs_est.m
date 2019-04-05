function abs_h=abs_est(y,SNR)

switch SNR
    case{1}
        load abs_SNR1;
%         load angle_SNR1;
    case{2}
        load abs_SNR2;
%         load angle_SNR2;
    case{3}
        load abs_SNR3;
%         load angle_SNR3;
    case{4}
        load abs_SNR4;
%         load angle_SNR4;
    case{5}
        load abs_SNR5;
%         load angle_SNR5;
    case{6}
        load abs_SNR6;
%         load angle_SNR6;
    case{7}
        load abs_SNR7;
%         load angle_SNR7;
    case{8}
        load abs_SNR8;
%         load angle_SNR8;
    case{9}
        load abs_SNR9;
%         load angle_SNR9;
    case{10}
        load abs_SNR10;
%         load angle_SNR10;

end
    


indim = size(y,1);

inputdim = indim;

testy = y;
abs_y = abs(testy);

yy = zeros(inputdim,1);

yy=abs_y;


testYY = yy;
testYY = (testYY-lowvecinput)./(upvecinput-lowvecinput);


simHH = sim(net,testYY);




thh = simHH;
thh = thh.*(upvecoutput-lowvecoutput) + lowvecoutput;


abs_h=thh;

 end

