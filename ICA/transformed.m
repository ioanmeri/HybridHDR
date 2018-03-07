function [ Tc,mean22 ] = transformed(a)
load('W.mat'); %Base Matrix%
% Converting Values from space [16 235] to [0 1]
a = a-16;
a = a./219;
%--- Sliding Window to Y channel for the ICA fusion ----%
Sc1 = im2col(a,[2 2],'sliding');
%---- Saving Mean Matrix to use later ---%
mean22 = mean(Sc1);
%---- Mean Remove from the Sliding Window ----%
Sc1 = double(Sc1) - repmat(mean22,[size(Sc1,1) 1]);
%--- Moving to TRANSFORM DOMAIN -------%
Tc = W*Sc1; 
end

