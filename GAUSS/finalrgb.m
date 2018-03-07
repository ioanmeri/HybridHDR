function [ frgb] = finalrgb( y,ry)

y1 = y*219; y1 = y1+16;
fimage = zeros(size(y1,1),size(y1,2),3);
fimage(:,:,1) = y1;
rycbcr = rgb2ycbcr(ry);
fimage(:,:,2) = rycbcr(:,:,2);
fimage(:,:,3) = rycbcr(:,:,3);
fimage = uint8(fimage);
frgb = ycbcr2rgb(fimage);


end

