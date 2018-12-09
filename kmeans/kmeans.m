clc
close all
clear
img = imread('../img/persian_cat.jpg');
style_img = imread('../output/Persian Cat + Hokusai.jpg');
img = double(img);
img = imresize(img, 500/size(img,1));
style_img = imresize(style_img, 500/size(style_img,1));
% figure;imshow(uint8(img));imwrite(uint8(img), '../img/ppt/1.jpg')
% figure;imshow(style_img);imwrite(uint8(style_img), '../img/ppt/2.jpg')

densitymap = double(generateDensityMap(img, 40));
% figure;imshow(densitymap/max(max(densitymap)));imwrite(uint8(255*densitymap/max(max(densitymap))), '../img/ppt/3.jpg')

[m, n, ~] = size(img);
k = 2;
locationscale = 1.2;
wd = 1.4;

wx = locationscale * 255/n;
wy = locationscale * 255/m;
m = round(wx*m);
n = round(wy*n);
densitymap = densitymap * 255 * wd / max(max(densitymap));
d = round(max(max(densitymap)));
[y, x] = find(img(:,:,1)<999999999);
% figure;imshow(reshape(x/max(max(x)),size(img,1),size(img,2)));imwrite(uint8(255*reshape(x/max(max(x)),size(img,1),size(img,2))), '../img/ppt/4.jpg')
% figure;imshow(reshape(y/max(max(y)),size(img,1),size(img,2)));imwrite(uint8(255*reshape(y/max(max(y)),size(img,1),size(img,2))), '../img/ppt/5.jpg')
r = img(:,:,1);%imwrite(uint8(cat(3, img(:,:,1),zeros(size(img,1),size(img,2),2))), '../img/ppt/6.jpg')
g = img(:,:,2);%imwrite(uint8(cat(3, zeros(size(img,1),size(img,2)), img(:,:,2),zeros(size(img,1),size(img,2)))), '../img/ppt/7.jpg')
b = img(:,:,3);%imwrite(uint8(cat(3, zeros(size(img,1),size(img,2),2), img(:,:,3))), '../img/ppt/8.jpg')
im = [r(:) g(:) b(:) wx*x wy*y wd*densitymap(:)];
c1 = [randi([1 255]) randi([1 255]) randi([1 255]) randi([1 n]) randi([1 m]) randi([1 d])];
c2 = [-1 -1 -1 -1 -1 -1];
while sum(c1 == c2) ~= 0 || sum(c2 == -1) ~= 0
    c2 = [randi([1 255]) randi([1 255]) randi([1 255]) randi([1 n]) randi([1 m]) randi([1 d])];
end
lable1 = [];
lable2 = [];
while 1
    dist1 = sum((im - c1).^2,2);
    dist2 = sum((im - c2).^2,2);
    lable1 = find(dist1 < dist2);
    lable2 = find(dist1 >= dist2);
    mean1 = sum(im(lable1,:))/size(im(lable1),1);
    mean2 = sum(im(lable2,:))/size(im(lable2),1);
    if sum(c1 - mean1) == 0 && sum(c2 - mean2) == 0
        break
    end
    c1 = mean1;
    c2 = mean2;
end
im1 = ones(size(im(:,1:3)));
size(im1);
im1(lable1,:) = 0;
im2 = ones(size(im(:,1:3)));
im2(lable2,:) = 0;
im1 = uint8(reshape(im1,size(img)));
im2 = uint8(reshape(im2,size(img)));
% figure; imshow(im1.*uint8(img));imwrite(uint8(im1.*uint8(img)), '../img/ppt/9.jpg')
% figure; imshow(im2.*uint8(img));imwrite(uint8(im2.*uint8(img)), '../img/ppt/10.jpg')

figure; imshow(uint8(img));
while 1
    try 
        temp = int32(ginput(1));
    catch
        break;
    end
    index = uint8(sum(im1(temp(2), temp(1),:)) == 0);
    imshow((1-index)*im1.*style_img + (1-index)*im2.*uint8(img) + index*im1.*uint8(img) + index*im2.*style_img);
end