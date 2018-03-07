function [ tonesize ] = tone_size(bfil,filtered,Cr,Cg,Cb,size)

% --- Histogram equalization on Edges 
filtered2 = abs(1-size)*filtered + size*adapthisteq(filtered);
% --- Detail layer: D = L - B
Detail = filtered2 - bfil;

% HSV = rgb2hsv(uint8(Detail));
% --- Smoothing with gaussian blur the Details
G = fspecial('gaussian',[16 16],160);
Ig = imfilter(Detail,G,'same');

% --- Apply an offset and a scale to the base: B' = (B - o) * s
o=max(filtered(:));
dR=4; %%%%% For lower parameters of dR, we get more interesting results
s=dR/(max(filtered(:))-min(filtered(:)));
bplus = (filtered2 - o)*s;
% bplus2 = 0.9*bplus + 0.1*histeq(bplus);
%  --- Reconstruct the log intensity: O = 2^(B' + D)
out1 = 2.^(bplus + Ig); 

red = out1.*Cr*255;
green = out1.*Cg*255;
blue = out1.*Cb*255;
output(:,:,1) = red;
output(:,:,2) = green;
output(:,:,3) = blue;
t = find(output<0);
output(t) = 0;
t = find(output>255);
output(t) = 255;
tonesize = uint8(output);

end

