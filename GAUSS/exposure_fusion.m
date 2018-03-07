
function R = exposure_fusion(I,m)

r = size(I,1);
c = size(I,2);
N = size(I,4);

W = ones(r,c,N);

%compute the measures and combines them into a weight map
contrast_parm = m(1);
sat_parm = m(2);
wexp_parm = m(3);

if (contrast_parm > 0)
    W = W.*contrast(I).^contrast_parm;
end
if (sat_parm > 0)
    W = W.*saturation(I).^sat_parm;
end
if (wexp_parm > 0)
    W = W.*well_exposedness(I).^wexp_parm;
end

%normalize weights: make sure that weights sum to one for each pixel
W = W + 1e-12; %avoids division by zero
W = W./repmat(sum(W,3),[1 1 N]);

% create empty pyramid
pyr = gaussian_pyramid(zeros(r,c,3));
nlev = length(pyr);

% multiresolution blending
for i = 1:N
    % construct pyramid from each input image
	pyrW = gaussian_pyramid(W(:,:,i));
	pyrI = laplacian_pyramid(I(:,:,:,i));
    
    % blend
    for l = 1:nlev
        w = repmat(pyrW{l},[1 1 3]);
        pyr{l} = pyr{l} + w.*pyrI{l};
    end
end

% reconstruct
R = reconstruct_laplacian_pyramid(pyr);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% contrast measure
function C = contrast(I)
h = [0 1 0; 1 -4 1; 0 1 0]; % laplacian filter
N = size(I,4);
C = zeros(size(I,1),size(I,2),N);
for i = 1:N
    mono = rgb2gray(I(:,:,:,i));
    C(:,:,i) = abs(imfilter(mono,h,'replicate'));
end

% saturation measure
function C = saturation(I)
N = size(I,4);
C = zeros(size(I,1),size(I,2),N);
for i = 1:N
    % saturation is computed as the standard deviation of the color channels
    R = I(:,:,1,i);
    G = I(:,:,2,i);
    B = I(:,:,3,i);
    mu = (R + G + B)/3;
    C(:,:,i) = sqrt(((R - mu).^2 + (G - mu).^2 + (B - mu).^2)/3);
end

% well-exposedness measure
function C = well_exposedness(I)
sig = .2;
N = size(I,4);
C = zeros(size(I,1),size(I,2),N);
for i = 1:N
    R = exp(-.5*(I(:,:,1,i) - .5).^2/sig.^2);
    G = exp(-.5*(I(:,:,2,i) - .5).^2/sig.^2);
    B = exp(-.5*(I(:,:,3,i) - .5).^2/sig.^2);
    C(:,:,i) = R.*G.*B;
end


