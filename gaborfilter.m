function [region_mask]=main(imgs)
warning off;
iptsetpref('ImshowBorder','tight');
 
tsta=cputime;

im =imgs
if(size(im,3)==3)
    im = double(rgb2gray(uint8(im)));
end

if(max(im(:)) > 255)
    im = (double(im)*255)/65535;    
end


w     = 5;       % bilateral filter half-width
sigma = [5 0.1]; % bilateral filter standard deviations
im = double(im)/max(im(:));
im = 255*bfilter2(im,w,sigma);
im = (imresize(im,.5,'bilinear'));
img=im;


[sx,sy]=size(im);
time1=cputime-tsta;

%% EXTRACT LOCAL KEYPOINTS:
disp('FAST corner extraction...')

tsta=cputime;

[loch, Ix, Iy] = kp_harris(im);

Imag=Ix.^2+Iy.^2;
mask=Imag>.1*max(Imag(:));
Ix2=Ix.*mask;
Iy2=Iy.*mask;

loch = fast_corner_detect_9(im,30);loch=fliplr(loch);
%loch = fast_corner_detect_9(im,50);loch=fliplr(loch);

time2=cputime-tsta;

figure;imshow(im,[]); hold on;
plot(loch(:,2), loch(:,1),'r+'); hold off;
   

%% FIND KEYS, DOMINANT DIRECTIONS AND WEIGHTS: 
disp('Finding local invariants...')

tsta=cputime;

dirmat = atan2(Iy2,-Ix2);

L= bwlabel(mask,4);

szl=size(loch,1);

weightvec=[];
for i=1:szl
    weightvec(i)=sum(sum(L==L(loch(i,1), loch(i,2))))/10;
end;

weightvec(find(weightvec==0))=5;
weightvec(find(weightvec>150))=5;

h=1;
for i = 1:szl
   if (loch(i,1)>5)&&(loch(i,1)<(sx-5))&&(loch(i,2)>5)&&(loch(i,2)<(sy-5))
    a = dirmat((loch(i,1)-1):(loch(i,1)+1), (loch(i,2)-1):(loch(i,2)+1));
    [k,l] = find(abs(a)>0);
    dir(h) = sum(a(:))/(size(k,1)+10^-5);
    locs(h,1) = loch(i,1);
    locs(h,2) = loch(i,2);
    weight(h)=weightvec(i);
    h=h+1;
   end;
end;


time3=cputime-tsta;

%% VOTE: 
disp('Voting...')

tsta=cputime;


b_mask = votedirections9(locs(:,1), locs(:,2), dir, weight*5, sx, sy);

time4=cputime-tsta;

%figure; imshow(b_mask,[]);colormap(jet), colorbar
%figure; mesh(b_mask);axis ij
figure; mesh(b_mask/max(b_mask(:)));axis ij

normalized_votes = b_mask/max(b_mask(:));
region_mask = normalized_votes > 0.4*max(normalized_votes(:));
region_boundary = imdilate(region_mask,strel('disk',2)) - region_mask;
%figure; imshow(region_mask); 
[x,y] = find(region_boundary);

figure;imshow(im,[]);
hold on
plot(y,x,'.y');

%% FIND POSSIBLE BUILDING LOCATIONS:
disp('Finding buildings without shadow...')

tsta=cputime;

mv=max(b_mask(:));
seed = find_extrema2(b_mask, .4*mv,10);
%seed = find_extrema2(b_mask, graythresh(b_mask), 3);

seed_mask = zeros(size(im));
for(i =1:size(seed))
    seed_mask(seed(i,1),seed(i,2)) = 1;
end
L2 = bwlabel(imdilate(seed_mask, strel('disk', 6)));
s  = regionprops(L2, 'centroid');
seed2 = cat(1, s.Centroid);

time5=cputime-tsta;

figure;imshow(im,[]);
hold on
% du = plot(seed2(:,1),seed2(:,2),'ks');
% set(du,'markersize',10);
% set(du,'markerfacecolor','y');

for a=1:size(seed2,1)
du = plot(seed2(a,1),seed2(a,2),'ks');
set(du,'markersize',10);
set(du,'markerfacecolor','y');
end;
hold off

%% 

timemat=[time1;time2;time3;time4;time5;];
disp(timemat)

disp('')
disp(['Building detection without shadow = ' num2str(sum(timemat(1:5))) ' sec.']);

%%


timemat=[time1;time2+time3;time4;time5;];
disp(timemat)

end

