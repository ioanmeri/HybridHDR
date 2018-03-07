function [ unsharp ] = Unsharp( a )

h = waitbar(0,'Applying Unsharp Mask...');
set(h,'Name','Unsharp Masking');
c = imsharpen(a,'Radius',25,'Amount',0.2); %50
waitbar(0.5);
unsharp=imblend(c,a,1,'normal',1);
waitbar(1);
close(h);
end

