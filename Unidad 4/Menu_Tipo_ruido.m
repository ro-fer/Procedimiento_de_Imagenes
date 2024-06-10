clc; clear all; close all; 
%%Practica 4: Degradacion y restauracion de imagenes
%Ejercicio 1: Genere ruido Gaussiano, Rayleig, exponencial,uniforme, sal,pimienta, sal
% y pimienta y agreguelo a una imagen. Observar como se degrada la imagen

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
%Menu para ver que tipo de ruido voy a utilizar :/
s = menu('¿Que tipo de ruido desea aplicar?', '1) Gaussiano', '2) Rayleig ', '3) Exponencial','4) Uniforme ', '5) Sal', '6) Pimienta', '7) Sal y Pimienta');
tipo = '';
switch s
    case 1
        IconRuido = imnoise(I,'gaussian');
        tipo = 'Gausiana';
    case 2
        IconRuido = imnoise(I,'gaussian') ;
        tipo = 'Rayleig';
    case 3
        IconRuido = imnoise(I,'gaussian');
        tipo = 'Exponencial';
    case 4
        IconRuido =  imnoise(I,'speckle');
        tipo = 'Uniforme';
    case 5
        IconRuido = imnoise(I,'salt');
        tipo = 'Sal';
    case 6
        IconRuido = imnoise(I,'pepper');
        tipo = 'Pimienta';
    case 7
        IconRuido = imnoise(I,'salt & pepper');
        tipo = 'Sal y pimienta';
end

figure()
subplot(1,2,1);imshow(I);title('Imagen Original')
subplot(1,2,2);imshow(IconRuido);title(['Imagen con ruido ', tipo])
