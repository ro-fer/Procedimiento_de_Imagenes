%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio  : Abra una imagen y aplique diferentes tipos de filtros pasa
%bajos

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

%Filtro Pasa Bajos

FBajo1= [0 1 0; 1 1 1; 0 1 0]/5;
FBajo2= ones(3)/9;
FBajo3=[1 1 1; 1 2 1; 1 1 1]/10;
FBajo4 =[1 2 1; 2 4 2; 1 2 1]/16;

%
OFB1 = conv2(I,FBajo1);
OFB2 = conv2(I,FBajo2);
OFB3 = conv2(I,FBajo3);
OFB4 = conv2(I,FBajo4);

figure()
subplot(231);imshow(I);title('Imagen Original')
subplot(232);imshow(OFB1);title('Imagen con Filtro Bajos 1')
subplot(233);imshow(OFB2);title('Imagen con Filtro Bajos 2')
subplot(234);imshow(OFB3);title('Imagen con Filtro Bajos 3')
subplot(235);imshow(OFB4);title('Imagen con Filtro Bajos 4')
