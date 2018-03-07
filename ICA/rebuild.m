function [ Fusedy ] = rebuild(hdryfin,my,rows,cols)

Fusedy1 = zeros(rows,cols);
hdryfin=hdryfin+ones(4,1)*my;
i=0;
for h=1:size(Fusedy1,2)-2+1
    for k=1:size(Fusedy1,1)-2+1
        i = i+1;
        tmpc = reshape(hdryfin(:,i),[2 2]);
        Fusedy1(k:k+1,h:h+1)= Fusedy1(k:k+1,h:h+1)+ tmpc;
    end
end
Fusedy = Fusedy1/4;
end

