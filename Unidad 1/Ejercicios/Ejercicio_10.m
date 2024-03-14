close all, clear all, clc
% leo una imagen y la convierto a escala de grises
[file,dir] = uigetfile('*.bmp;*.jpg;*.png; *.tif'); %filtro para archivos bmp, jpg y png
filename = [dir,file];
info = imfinfo(filename);
switch info.ColorType
    case 'indexed'
        [Iorig,map] = imread(filename);
        I = ind2gray(Iorig,map); %convierto de indexada a escala de grises

    case 'grayscale'
        I = imread(filename);
        
    case 'truecolor'
        Iorig = imread(filename);
        I=rgb2gray(Iorig); %convierto de RGB a escala de grises       
end
%expandir al rango dinamico
smin =0;
smax= 1;
rmin = double(min(I(:)))/255;
rmax = double(max(I(:)))/255;
O = imadjust(I, [rmin rmax], [smin smax]);
figure
subplot(2,2,1);
imshow(I, [0 255]);colorbar;
title('Imagen original en escala de grises')
subplot(2,2,2);colorbar;
imhist(I);
title('Histograma de la imagen original en escala de grises')
subplot(2,2,3);
imshow(O, [0 255]);
title('Imagen modificada en escala de grises')
subplot(2,2,4);
imhist(O);
title('Histograma de la imagen  con brillo modificada')