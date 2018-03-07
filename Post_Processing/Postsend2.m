function [bfil,filtered,Cr,Cg,Cb] = Postsend2(x)

a = double(x);
r = a(: , :, 1);
g = a(: , :, 2);
b = a(: , :, 3);
% --- the intensity (I) ---
I2 = (r + g + b)./3;
%%%%%% Ensure that 0/0 or A/0 never occurs.
Cr = (r+eps) ./ (I2+eps);
Cg = (g+eps) ./( I2+eps);
Cb = (b+eps) ./( I2+eps);
% --- Log intensity: L = log2(I)
L = log2(double(I2));
L(L<0) = 0;
bfil = L./max(L(:));
% --- Filter that with a bilateral filter: B = bf(L)
filtered = bfilter2(bfil,3,[0.1 0.1]); % 3 0.1 0.1


end




