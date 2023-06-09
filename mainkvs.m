
 
function [mask]=kmeanscluster(img)
a=img;
imshow(a);
figure
I=rgb2gray(a);
disp(I)
imshow(I);
%B=zeros([160 384]);
%B=double(B);
%B(1:160,1:384)=I(3:162,8:391);
[mu,mask]=kmeanskvs(I,2)
%imshow(mask)
mask=mat2gray(mask);
%imshow(mask)
for i=1:32
    for j=1:32
        if (mask(i,j)==1)
            D(i,j)=0;
            
        else
            D(i,j)=1;
            
        
        end
    end
end
%imshow(D,[])
c=0;
for m=1:32
    for n=1:32
        if(D(m,n)==0)
            c=c+1;
        else
            c=c+0;
        end
        n=n+1;
    end
    m=m+1;
    
end

% mask(:,:,[1 3]) = 0;
figure
imshow(mask)
colormap(gca,[1 0 0; 0 1 0]);
end





