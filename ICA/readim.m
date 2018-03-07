function[a, b, c] = readim(align1,align2,align3)
Or1ycbcr = rgb2ycbcr(align1);
Or2ycbcr = rgb2ycbcr(align2);
Or3ycbcr = rgb2ycbcr(align3);
clear align1;
clear align2;
clear align3;
    %------ Isolation Of the Y Channels----%
a = double(Or1ycbcr(:,:,1));
b = double(Or2ycbcr(:,:,1));
c = double(Or3ycbcr(:,:,1));
clear Or1ycbcr;
clear Or2ycbcr;
clear Or3ycbcr;      

end




