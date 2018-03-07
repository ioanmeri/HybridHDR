function ry = gauss(a,b,c)
sz = size(a);
r1 = sz(1,1,1); 
c1 = sz(1,2,1);
I = zeros(r1,c1,3,3);
I(:,:,:,1) =double(a)/255;
I(:,:,:,2) =double(b)/255;
I(:,:,:,3) =double(c)/255;
R = exposure_fusion(I,[1 1 1]);
rf = R; t = find(rf<0); rf(t) = 0;
y = find(rf>1); rf(y) = 1;
ry = uint8(rf.*255);
save('ry','ry');
end

