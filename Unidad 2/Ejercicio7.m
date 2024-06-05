%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio


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

I = im2double(I); 
format rat 

Iruido=imnoise(I,'salt & pepper');
FBajo1= [0 1 0; 1 1 1; 0 1 0]/5;
OFB1 = conv2(Iruido,FBajo1);
Omediana=medfilt2(Iruido);

figure()
subplot(2,2,1);imshow(I);title('Imagen original')
subplot(2,2,2);imshow(Iruido);title('Imagen original con ruido sal y pimienta')
subplot(2,2,3);imshow(OFB1);title('Imagen con filtro pasa bajos')
subplot(2,2,4);imshow(Omediana);title('Imagen con filtro mediana 3x3')
