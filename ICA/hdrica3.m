load Ty1;
load Ty2;
load Ty3;
Trans_hdry = zeros(size(Ty1,1),size(Ty1,2));

for i=1:size(Ty1,1)
        waitbar(0.62 + (i/size(Ty1,1)*0.23));
        f = [Ty1(i,:);Ty2(i,:);Ty3(i,:)];
        [idx2 idx] = max(abs(f));
        for j=1:size(Ty1,2)
            Trans_hdry(i,j) = f(idx(j),j);
        end
end
clear Ty1 Ty2 Ty3;