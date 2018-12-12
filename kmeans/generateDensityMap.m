function map = generateDensityMap(image,w_width)
    gray_image = rgb2gray(uint8(image));
    M = [-1 2 -1];
    Lx = imfilter(gray_image, M, 'replicate', 'conv');
    Ly = imfilter(gray_image, M', 'replicate', 'conv');
    del2f = abs(Lx) + abs(Ly);
    M = [-1 3 -1];
%     Lx = imfilter(del2f, M, 'replicate', 'conv');
%     Ly = imfilter(del2f, M', 'replicate', 'conv');
%     del2f = abs(Lx) + abs(Ly);
    imwrite(uint8(del2f),'../img/ppt/11.jpg')
    map = imgaussfilt(del2f, w_width);
end