%Leo una imagen, la paso a escala de grises y luego le cambio el contraste segun lo que el usario indique
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
%modifico brillo
k = input('Ingrese k:\n');
O = I + k;
figure
subplot(2,2,1);
imshow(I);
title('Imagen original en escala de grises')
subplot(2,2,2);
imhist(I);
title('Histograma de la imagen original en escala de grises')
subplot(2,2,3);
imshow(O);
title('Imagen  con brillo modificada')
subplot(2,2,4);
imhist(O);
title('Histograma de la imagen  con brillo modificada')
