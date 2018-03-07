function [ lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN ] = Burn( or )
XYZ = colorspace('RGB->XYZ',or);
X = XYZ(:,:,1);
Y = XYZ(:,:,2);
Z = XYZ(:,:,3);
[MM, NN] = size(X);
s1 = MM * NN;
LMS_var = [reshape(X,1,s1); reshape(Y,1,s1); reshape(Z,1,s1)];
 
 Mat = [0.4002 0.7075 -0.0807;
       -0.2280 1.1500 0.0612;
       0 0 0.9184];
   
lms = Mat*LMS_var;
t1 = find(lms(1,:)>=0);
t2 = find(lms(1,:)<0);
t1_2 = find(lms(2,:)>=0);
t2_2 = find(lms(2,:)<0);
t1_3 = find(lms(3,:)>=0);
t2_3 = find(lms(3,:)<0);

lms1(1,t1) = double(lms(1,t1)).^(0.43);
lms1(1,t2) = -double(-lms(1,t2)).^(0.43);
% 
lms1(2,t1_2) = double(lms(2,t1_2)).^(0.43);
lms1(2,t2_2) = -double(-lms(2,t2_2)).^(0.43);
% 
lms1(3,t1_3) = double(lms(3,t1_3)).^(0.43);
lms1(3,t2_3) = -double(-lms(3,t2_3)).^(0.43);

LMS(1:MM,1:NN,1)=reshape(lms(1,:),[MM NN]);
LMS(1:MM,1:NN,2)=reshape(lms(2,:),[MM NN]);
LMS(1:MM,1:NN,3)=reshape(lms(3,:),[MM NN]);

 Mat2 = [0.400 0.4000 0.2000;
       4.4550 -4.8510 0.3960;
       0.8056 0.3572 -1.1628];
   

ipt = Mat2*lms;
ipt2 = Mat2*lms1;
IPTsp(1:MM,1:NN,1)=reshape(ipt(1,:),[MM NN]);
IPTsp(1:MM,1:NN,2)=reshape(ipt(2,:),[MM NN]);
IPTsp(1:MM,1:NN,3)=reshape(ipt(3,:),[MM NN]);
%% ftakame ston ipt xwro %%
iptlume = ipt(1,:);
iptlume2 = ipt2(1,:);
iptP = ipt(2,:);
iptT = ipt(3,:);
iptchroma = sqrt(iptP.^2 + iptT.^2);

%% --- Saturation Thresholding via Chroma --%
thrch1 = find(iptchroma<=0.1);
thrch2 = find(iptchroma <0.9 & iptchroma >0.1);
thrch3 = find(iptchroma>=0.9);
%%If chroma<0.1 the color is achromatic
%%if chroma>0.9 already saturated, no need for boost
iptPnew(thrch1) = iptP(thrch1);
iptPnew(thrch3) = iptP(thrch3);
iptTnew(thrch1) = iptT(thrch1);
iptTnew(thrch3) = iptT(thrch3);

%% --- Luminosity Thresholds --%
thr1 = find(iptlume2<=0.05);
thr2 = find(iptlume2 <0.9 & iptlume2 >0.05);
thr3 = find(iptlume2>=0.9);
lumeout(thr3) = iptlume(thr3);
lumeout(thr1) = iptlume(thr1);

%% --- Cumulative distribution function --%
%% Determines if the image should be darkened or lightened via beta
[f,q]  = ecdf(iptlume2);
l20 = max(f(q<=0.2));
l50 = max(f(q<=0.5));
l80 = max(f(q<=0.8));
paramLowThresCDF50 = 0.2;
paramBetaMax = 0.15;
paramHighThresCDF50 = 0.8;
if (l50 < paramLowThresCDF50)
    beta = -paramBetaMax;
elseif (l50> paramHighThresCDF50)
    beta = paramBetaMax;
else
    beta = ((2*abs(paramBetaMax)*(l50 - paramLowThresCDF50))/ ...
        (paramHighThresCDF50 - paramLowThresCDF50)) - paramBetaMax;
end
paramThresCDF80 = 0.8;
paramThresCDF20 = 0.2;
if (beta<0) && (l80 >= paramThresCDF80)
    beta = 0;
end
if (beta>0) && (l20<=paramThresCDF20)
    beta = 0;
end
lumeout(thr2) = iptlume(thr2) - beta*sin(pi*iptlume(thr2));

% if ((beta<0) && (abs(beta)>=0.75*paramBetaMax))
%     boost = 0.4;
% else
%     boost = 0.2;
% end
% 


end

