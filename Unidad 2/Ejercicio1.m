%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio 1 : Abra una imagen y agreguele ruido con imnoise

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

ISalPimienta = imnoise(I,'salt & pepper');
IGaussiana =imnoise(I,'gaussian');

figure()
subplot(131);imshow(I);title('Imagen Original')
subplot(132);imshow(ISalPimienta);title('Imagen con ruido sal y pimienta')
subplot(133);imshow(IGaussiana);title('Imagen Gaussiano')
