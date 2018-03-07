function  outpict=imblend(FG,BG,opacity,blendmode,amount)
%   IMBLEND(FG, BG, OPACITY, BLENDMODE,{AMOUNT})
%       blend images or imagesets as one would blend layers in GIMP or
%       Photoshop.  
%
%   FG, BG are RGB image arrays of same H,V dimension
%       both can be single images or 4-D imagesets of equal length
%       can also blend a single image with a 4-D imageset
%       mismatches of dimensions 3:4 result in array expansion
%       allows blending static overlays with an entire animation
%       mismatches of dimensions 1:2 are not supported
%   OPACITY is a scalar from 0 to 1
%       defines mixing of blended result and original BG
%   AMOUNT is a scalar (optional, default 1)
%       used to internally scale the influence of blend calculations
%   BLENDMODE is a string assignment (see list)
%
%
%   MODES: 
%       normal      
%       screen
%       overlay     (standard method)
%       softlight   (GIMP overlay)
%       hardlight
%       vividlight
%       hardmix     (similar to posterization)                  amount:[0 1]
%       posterize   (stronger influence from mask)
%       colordodge  (similar to GIMP dodge)                     amount:[0 1]
%       colorburn   (similar to GIMP burn)                      amount:[0 1]
%       lineardodge                                             amount:[0 1]
%       linearburn                                              amount:[0 1]
%       lighten RGB     (lighten only (RGB))
%       darken RGB      (darken only (RGB))
%       lighten Y       (lighten only (luma only))
%       darken Y        (darken only (luma only))
%       scale add       (add bg to fg deviation from mean)     amount:(-inf to +inf)
%       scale mult      (scale bg by mean-normalized fg)       amount:(-inf to +inf)
%       multiply
%       divide
%       addition
%       subtraction
%       difference
%       exclusion 
%       hue         
%       saturation  
%       value    
%       luma1       (uses colorspace() YIQ conversion)
%       luma2       (Image Processing toolbox YIQ conversion)
%       lightness   (approx identical to intensity)
%       intensity
%       color       
%       permute H>H     (rotates hue by mask hue)               amount:(-inf to +inf)
%       permute dH>H    (rotates hue by hue difference)         amount:(-inf to +inf)
%       permute Y>H     (rotates hue by mask luma)              amount:(-inf to +inf)
%       permute dY>H    (rotates hue by luma difference)        amount:(-inf to +inf)
%       permute H>HS     (rotates color by mask hue)            amount:(-inf to +inf)
%       permute dH>HS    (rotates color by hue difference)      amount:(-inf to +inf)
%       permute Y>HS     (rotates color by mask luma)           amount:(-inf to +inf)
%       permute dY>HS    (rotates color by luma difference)     amount:(-inf to +inf)
%
%   NOTE:
%       modes which accept 'amount' argument are marked with effective range
%       dH>H and dH>HS permutations are same as 'hue' when amount==-1
%       color permutations combine hue rotation and saturation blending
%           saturation blending is maximized when abs(amount)==1
%
%   CLASS SUPPORT:
%       Accepts images of 'uint8', 'double', and 'logical'
%       Return type is inherited from BG
%       In the case of a 'double' input, any image containing values >1
%       is assumed to have a white value of 255. 

%   SOURCES:
%       http://www.venture-ware.com/kevin/coding/lets-learn-math-photoshop-blend-modes/
%       http://www.deepskycolors.com/archive/2010/04/21/formulas-for-Photoshop-blending-modes.html
%       http://en.wikipedia.org/wiki/Blend_modes
%       http://en.wikipedia.org/wiki/YUV
%       http://www.kineticsystem.org/?q=node/13
%       http://www.simplefilter.de/en/basics/mixmods.html

if nargin ~= 5
    amount=1;
end


% i had intended to make this more class-insensitive, but i never need it
% output type is inherited from BG, assumes white value of either 1 or 255
inclassFG=class(FG);
inclassBG=class(BG);
if strcmp(inclassFG,'uint8')
    fgmax=255;
elseif strcmp(inclassFG,'double')
    if max(max(max(FG)))<=1
        fgmax=1;
    else 
        fgmax=255;
    end
elseif strcmp(inclassFG,'logical')
    fgmax=1;
else
    disp('IMBLEND: unsupported class for FG')
    return
end

if strcmp(inclassBG,'uint8')
    bgmax=255;
elseif strcmp(inclassBG,'double')
    if max(max(max(BG)))<=1
        bgmax=1;
    else 
        bgmax=255;
    end
elseif strcmp(inclassBG,'logical')
    bgmax=1;
else
    disp('IMBLEND: unsupported class for BG')
    return
end


% expand along dimension 3 where necessary
if size(FG,3)<size(BG,3)
    FG=repmat(FG,[1 1 size(BG,3) 1]);
elseif size(FG,3)>size(BG,3)
    BG=repmat(BG,[1 1 size(FG,3) 1]);
end

% check if height & width match
sFG=size(FG);
sBG=size(BG);  
if any(sFG(1:2)~=sBG(1:2)) 
    disp('IMBLEND: images of mismatched dimension')
    return
end

% check frame count and expand as necessary
if length(sFG)~=4 && length(sBG)~=4 % two single images
    images=1;
else
    if length(sFG)~=4 % single FG, multiple BG
        FG=repmat(FG,[1 1 1 sBG(4)]);
    elseif length(sBG)~=4 % multiple FG, single BG
        BG=repmat(BG,[1 1 1 sFG(4)]); sBG=size(BG);
    elseif sFG(4)~=sBG(4) % two unequal imagesets
        disp('IMBLEND: imagesets of unequal length')
        return
    end
    images=sBG(4);
end

% perform blend operations
outpict=zeros(sBG);    
for n=1:1:images
    I=double(BG(:,:,:,n))/bgmax;
    M=double(FG(:,:,:,n))/fgmax;

    switch lower(blendmode)
        case 'normal'
            R=M;

        case 'screen'
            R=1-((1-M).*(1-I));

        case 'overlay'  % actual standard overlay mode 
            hi=I>0.5; lo=I<=0.5;
            R=zeros(size(I));
            R(lo)=2*I(lo).*M(lo);
            R(hi)=1-2*(1-M(hi)).*(1-I(hi));

        case 'softlight' % same as GIMP 'overlay' due to legacy bug
            Rs=1-((1-M).*(1-I));
            R=(I.*((1-I).*M+Rs));

        case 'hardlight'
            hi=M>0.5; lo=M<=0.5;
            R=zeros(size(I));
            R(lo)=2*I(lo).*M(lo);
            R(hi)=1-2*(1-M(hi)).*(1-I(hi));

        case 'vividlight'  % test this; example formulae are inconsistent
            hi=M>0.5; lo=M<=0.5;
            R=zeros(size(I));
            R(lo)=1-(1-I(lo))./(2*M(lo));
            R(hi)=I(hi)./(1-2*(M(hi)-0.5));

        case 'posterize'  % actually a broken version of vividlight
            hi=M>0.5; lo=M<=0.5;
            R=zeros(size(I));
            R(lo)=(1-I(lo))./(2*(M(lo)-0.5));
            R(hi)=1-I(hi)./(1-2*M(hi));

        case 'hardmix' % ps mode similar to posterization
            amount=max(min(amount,1),0);
            Rs=M+I;
            R=Rs;
            R(Rs>1)=1*amount;
            R(Rs<1)=0;

        % DODGES/BURNS    
        case'colordodge'
            amount=max(min(amount,1),0);
            R=I./(1-M*amount);

        case 'colorburn'
            amount=max(min(amount,1),0);
            R=1-(1-I)./(M*amount+(1-amount));

        case 'lineardodge' % addition
            amount=max(min(amount,1),0);
            R=M*amount+I;

        case 'linearburn' 
            amount=max(min(amount,1),0);
            R=M*amount+I-1*amount;

        % SIMPLE MATH OPS    
        case 'lighten rgb' % lighten only (RGB, no luminance)
            R=max(I,M);

        case 'darken rgb' % darken only (RGB, no luminance)
            R=min(I,M);

        case 'lighten y' % lighten only (based on luminance)
            Myiq=colorspace('RGB->YIQ',M);
            Iyiq=colorspace('RGB->YIQ',I);
            mask=Myiq(:,:,1)>Iyiq(:,:,1);
            R=double(replacepixels(255*I,mask,255*M))/255;
            
        case 'darken y' % darken only (based on luminance)
            Myiq=colorspace('RGB->YIQ',M);
            Iyiq=colorspace('RGB->YIQ',I);
            mask=Myiq(:,:,1)<Iyiq(:,:,1);
            R=double(replacepixels(255*I,mask,255*M))/255;

        case 'multiply'
            R=M.*I;

        case 'divide'
            R=I./(M+1E-3);

        case 'addition' % same as lineardodge
            R=M+I;

        case 'subtraction'
            R=I-M;

        case 'difference'
            R=abs(M-I);

        case 'exclusion'
            R=M+I-2*M.*I;

        case 'hue'
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=Mhsv(:,:,1);
            R=hsv2rgb(Rhsv);    

        case 'saturation'
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,2)=Mhsv(:,:,2);
            R=hsv2rgb(Rhsv); 

        % V=max([R G B])
        % L=mean(max([R G B]),min([R G B]))
        % I=mean([R G B])
        % Y=[0.299 0.587 0.114]*[R G B]'

        case 'value'
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,3)=Mhsv(:,:,3);
            R=hsv2rgb(Rhsv); 

        % all colorspace() Y-swaps produce identical results within 1 LSB
        % (YUV, YIQ, YCbCr, YPbPr, YDbDr)
        case 'luma1' % swaps fg bg luma
            Myiq=colorspace('RGB->YIQ',M);
            Ryiq=colorspace('RGB->YIQ',I);
            Ryiq(:,:,1)=Myiq(:,:,1);
            R=colorspace('RGB<-YIQ',Ryiq);

        case 'luma2' % swaps fg bg luma (using IP toolbox)
            Myiq=rgb2ntsc(M);
            Ryiq=rgb2ntsc(I);
            Ryiq(:,:,1)=Myiq(:,:,1);
            R=ntsc2rgb(Ryiq); 

        % L and I swaps are calculated differently,  
        % but results are practically identical (within 1 LSB) 
        % for all available HSL and HSI conversion implementations
        case 'lightness' % swaps fg bg lightness
            Mhsl=colorspace('RGB->HSL',M);
            Rhsl=colorspace('RGB->HSL',I);
            Rhsl(:,:,3)=Mhsl(:,:,3);
            R=colorspace('RGB<-HSL',Rhsl);

        case 'intensity' % swaps fg bg intensity 
            Mhsi=colorspace('RGB->HSI',M);
            Rhsi=colorspace('RGB->HSI',I);
            Rhsi(:,:,3)=Mhsi(:,:,3);
            R=colorspace('RGB<-HSI',Rhsi);

        case 'color' % same as GIMP, swap H&S
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1:2)=Mhsv(:,:,1:2);
            R=hsv2rgb(Rhsv); 

        % HUE PERMUTATIONS 
        case 'permute y>h' % permutes bg hue based on fg luma
            factors=[0.299 0.587 0.114];
            osize=size(M(:,:,1));
            cscale=repmat(reshape(factors,1,1,3),[osize 1]);
            Y=sum(M.*cscale,3);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+Y*amount,1);
            R=hsv2rgb(Rhsv); 

        case 'permute h>h' % permutes bg hue based on fg hue
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+Mhsv(:,:,1)*amount,1);
            R=hsv2rgb(Rhsv);    

        case 'permute dy>h' % permutes bg hue based on luma difference
            factors=[0.299 0.587 0.114];
            osize=size(M(:,:,1));
            cscale=repmat(reshape(factors,1,1,3),[osize 1]);
            Ym=sum(M.*cscale,3);
            Yi=sum(I.*cscale,3);
            dY=Yi-Ym;
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+dY*amount,1);
            R=hsv2rgb(Rhsv); 

        % note that dH+H permutation is same as a hue swap when amount==-1
        case 'permute dh>h' % permutes bg hue based on hue difference
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            dH=Rhsv(:,:,1)-Mhsv(:,:,1);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+dH*amount,1);
            R=hsv2rgb(Rhsv); 

        % COLOR PERMUTATIONS (rotate hue and blend saturation)
        case 'permute y>hs' % permutes bg color based on fg luma
            factors=[0.299 0.587 0.114];
            osize=size(M(:,:,1));
            cscale=repmat(reshape(factors,1,1,3),[osize 1]);
            Y=sum(M.*cscale,3);
            amt=max(min(abs(amount),1),0); % needed since S-blending has limited range
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+Y*amount,1);
            Rhsv(:,:,2)=amt*Mhsv(:,:,2)+(1-amt)*Rhsv(:,:,2);
            R=hsv2rgb(Rhsv); 

        case 'permute h>hs' % permutes bg color based on fg hue
            amt=max(min(abs(amount),1),0); % needed since S-blending has limited range
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+Mhsv(:,:,1)*amount,1);
            Rhsv(:,:,2)=amt*Mhsv(:,:,2)+(1-amt)*Rhsv(:,:,2);
            R=hsv2rgb(Rhsv);    

        case 'permute dy>hs' % permutes bg color based on luma difference
            factors=[0.299 0.587 0.114];
            osize=size(M(:,:,1));
            cscale=repmat(reshape(factors,1,1,3),[osize 1]);
            Ym=sum(M.*cscale,3);
            Yi=sum(I.*cscale,3);
            dY=Yi-Ym;
            amt=max(min(abs(amount),1),0); % needed since S-blending has limited range
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+dY*amount,1);
            Rhsv(:,:,2)=amt*Mhsv(:,:,2)+(1-amt)*Rhsv(:,:,2);
            R=hsv2rgb(Rhsv); 

        % note that dH+H permutation is same as a hue swap when amount==-1
        case 'permute dh>hs' % permutes bg color based on hue difference
            amt=max(min(abs(amount),1),0); % needed since S-blending has limited range
            Mhsv=rgb2hsv(M);
            Rhsv=rgb2hsv(I);
            dH=Rhsv(:,:,1)-Mhsv(:,:,1);
            Rhsv(:,:,1)=mod(Rhsv(:,:,1)+dH*amount,1);
            Rhsv(:,:,2)=amt*Mhsv(:,:,2)+(1-amt)*Rhsv(:,:,2);
            R=hsv2rgb(Rhsv); 
            
        % SCALE ADD treats FG as an additive gain map with a null point at its mean
        case 'scale add'
            Mstretch=imadjust(M,stretchlim(M));
            centercolor=mean(mean(Mstretch,1),2);
            R=zeros(size(I));
            for c=1:1:3;
                R(:,:,c)=I(:,:,c)+(Mstretch(:,:,c)-centercolor(:,:,c))*amount;
            end

        % SCALE MULT treats FG as a gain map with a null point at its mean
        case 'scale mult'
            Mstretch=imadjust(M,stretchlim(M));
            centercolor=mean(mean(Mstretch,1),2);
            R=zeros(size(I));
            for c=1:1:3;
                R(:,:,c)=I(:,:,c).*(Mstretch(:,:,c)./centercolor(:,:,c))*amount;
            end
            
        otherwise
            disp('IMBLEND: unknown blend mode');
            return

    end

    R=min(R,1); 
    R=max(R,0);
    R(isnan(R))=1;
    outpict(:,:,:,n)=bgmax*(opacity*R + I*(1-opacity));
end

outpict=cast(outpict,inclassBG);

return