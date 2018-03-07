function [ multi ] = orton_size( hsv,outscreen,back,size)

h = waitbar(0,'Applying Gaussian Mask ...');
set(h,'Name','Gaussian Mask Progress');
s = round(size);
waitbar(0.2);
g = fspecial('gaussian',[s s],20);
waitbar(0.4);
or3 = imfilter(hsv,g);
waitbar(0.6);
screen=imblend(outscreen,back,0.33,'screen',1);
waitbar(0.8);
multi = imblend(or3,screen,0.33,'multiply',1);
waitbar(1);
close(h);

end

