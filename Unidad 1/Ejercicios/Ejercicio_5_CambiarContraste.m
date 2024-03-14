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
%modifico contraste
k = input('ingrese k:\n');
O = I * k;
figure
subplot(2,2,1);
imshow(I);
title('Imagen original en escala de grises')
subplot(2,2,2);
imhist(I);
title('Histograma de la imagen original en escala de grises')
subplot(2,2,3);
imshow(O);
title('Imagen  con contraste modificada')
subplot(2,2,4);
imhist(O);
title('Histograma de la imagen  con contraste modificada')