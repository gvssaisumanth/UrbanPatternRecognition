function mask = votedirections9(xs, ys, dir, weight, sx, sy)

mask = zeros(sx,sy);
[ymat,xmat]=meshgrid(1:sy,1:sx);

% Apply transform
x = xs' - weight .* sin(dir);
y = ys' + weight .* cos(dir);

sig=2*weight;

coef=3;

for i = 1:size(xs,1)
   
    xmin=max(1,x(i)-coef*sig(i));xmax=min(sx,x(i)+coef*sig(i));
    ymin=max(1,y(i)-coef*sig(i));ymax=min(sy,y(i)+coef*sig(i));

    xmat1=xmat(xmin:xmax,ymin:ymax);
    ymat1=ymat(xmin:xmax,ymin:ymax);
    
    mask(xmin:xmax,ymin:ymax) = mask(xmin:xmax,ymin:ymax)+ 1*(1/(sqrt(2*pi*sig(i))))*exp(-((xmat1-x(i)).^2+(ymat1-y(i)).^2)/(2*sig(i)));
end

