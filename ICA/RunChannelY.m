function[fusedy] = RunChannelY(a,b,c)
h = waitbar(0);
set(h,'Name','HDR Selection of the Luminance Channel');
waitbar(0.142,h,'This step may take a few minutes');
[Ay1,Ay2,Ay3] = readim(a,b,c);%Image read with readim() RGB-->YCbCr Save Y1,Y2,Y3

[Ty1,ma] = transformed(Ay1); %Values [0 1] || Slidind || Mean remove and Save Ty and mean
save('Ty1','Ty1'); save('ma','ma');
clear Ty1 ma Ay1;
waitbar(0.285,h,'1st Image has been tranformed into the ICA domain');
[Ty2,mb] = transformed(Ay2);
save('Ty2','Ty2'); save('mb','mb');
clear Ty2 mb Ay2;
waitbar(0.428,h,'2nd Image has been tranformed into the ICA domain');
[Ty3,mc] = transformed(Ay3);
waitbar(0.524,h,'3rd Image has been tranformed into the ICA domain');
save('Ty3','Ty3'); save('mc','mc');
clear Ty3 mc Ay3;
waitbar(0.62,h,'Choosing max coefficients');
hdrica3; %Find max_abs Ty Save Trans_hdry
load W;
Rev_hdry = pinv(W)*Trans_hdry; %Reversed, back to ycbcr domain
clear Trans_hdry; clear W;
load ma; load mb; load mc;
m1 = (ma + mb + mc)./3;
clear ma mb mc;
row = length(a(:,1,1)); col = length(b(1,:,1));
waitbar(0.85,h,'Rebuilding the fused image');
fusedy = rebuild(Rev_hdry,m1,row,col);
save('fusedy','fusedy');
waitbar(1); close(h)
end
