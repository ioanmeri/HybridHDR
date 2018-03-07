function [ rgb ] = auto_boost(lumeout,iptP,iptPnew,iptT,iptTnew,thrch2,MM,NN,boost )
 Mat2 = [0.400 0.4000 0.2000;
       4.4550 -4.8510 0.3960;
       0.8056 0.3572 -1.1628];
 Mat = [0.4002 0.7075 -0.0807;
       -0.2280 1.1500 0.0612;
       0 0 0.9184];
   %% 
   

iptPnew(thrch2) = iptP(thrch2) + boost*sin(pi*iptP(thrch2));
iptTnew(thrch2) = iptT(thrch2) + boost*sin(pi*iptT(thrch2));


%% --- Tranformation of the IPT color space back to RGB --%

ipt_final = [lumeout; iptPnew; iptTnew];
lms_final = inv(Mat2)*ipt_final;
xyzback = inv(Mat)*lms_final;
xyz_final(1:MM,1:NN,1)=(reshape(xyzback(1,:),[MM NN]));
xyz_final(1:MM,1:NN,2)=(reshape(xyzback(2,:),[MM NN]));
xyz_final(1:MM,1:NN,3)=(reshape(xyzback(3,:),[MM NN]));
cd('Post_Processing');
rgb = colorspace('RGB<-XYZ',xyz_final);
cd('../');



end

