function [ outscreen,hsv ] = Orton2( in )

back = in;
layer1 = in;

outscreen=imblend(layer1,back,1,'screen',1);
outmulti = imblend(outscreen,outscreen,1,'multiply',0.7);
hsi = colorspace('RGB->HSI',outmulti);
hsi(:,:,3) = adapthisteq(hsi(:,:,3));
hsi = colorspace('RGB<-HSI',hsi);

hsv = colorspace('RGB->HSV',hsi);
hsv(:,:,2) = hsv(:,:,2)*1.9;
hsv = colorspace('RGB<-HSV',hsv);

end

