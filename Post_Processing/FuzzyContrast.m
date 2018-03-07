function [ fuzzy ] = FuzzyContrast( in)


rgbinput = in;
labinput = applycform(rgbinput,makecform('srgb2lab'));
Lbpdfhe = fcnBPDFHE(labinput(:,:,1));
laboutput = cat(3,Lbpdfhe,labinput(:,:,2),labinput(:,:,3));
rgboutput = applycform(laboutput,makecform('lab2srgb'));

fuzzy = rgboutput;
end

