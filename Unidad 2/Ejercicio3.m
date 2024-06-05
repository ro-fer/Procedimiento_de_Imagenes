%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio  : Abra una imagen y aplique diferentes tipos de filtros pasa
%altos


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

%Filtro Pasa altos

FAlto1= [0 -1 0; -1 5 -1; 0 -1 0];
FAlto2= [-1 -1 -1; -1 9 -1; -1 -1 -1];
FAlto3=[1 -2 1; -2 5 -2; 1 -2 1];


%
OFA1 = conv2(I,FAlto1);
OFA2 = conv2(I,FAlto2);
OFA3 = conv2(I,FAlto3);

figure()
subplot(221);imshow(I);title('Imagen Original')
subplot(222);imshow(OFA1);title('Imagen con Filtro Altos 1')
subplot(223);imshow(OFA2);title('Imagen con Filtro Altos 2')
subplot(224);imshow(OFA3);title('Imagen con Filtro Altos 3')
