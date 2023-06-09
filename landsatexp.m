function [f]=landsatexp(img)
CIR=img;
NIR = im2single(CIR(:,:,1));
R = im2single(CIR(:,:,2));
ndvi = (NIR - R) ./ (NIR + R);
threshold = 0.2;
%if ndvi > 0
q = (ndvi > threshold )
ans=100 * numel(NIR(q(:))) / numel(NIR);
%imshow(q)
%colormap(gca,[1 0 0; 0 1 0]);
%title('NDVI with Threshold Applied')
f=(-0.01<ndvi<0.14)
display(f)
ans1=100 * numel(NIR(f(:))) / numel(NIR);
%plot(R(f(:)),NIR(f(:)),'r+')
figure
imshow(f);
colormap(gca,[1 0 0; 0 1 0]);
end
