%TP1, Ej1.15: Aplicar transformaciones geometricas a imagenes grayscale y
%observar los resultados
clc;close all;clear all

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

grado=input('Ingrese los grados a rotar. En numeros');

I_Rotada = imrotate(I,grado);
I_recorte = imcrop(I);
I_reflejada =fliplr(I);
I_volteada =flipud(I);

figure()
subplot(321);imshow(I); title('Imagen original')
subplot(322);imshow(I_Rotada);title('Imagen rotada con angulo ingresado')
subplot(323);imshow(I_recorte);title('Imagen Recortada')
subplot(324);imshow(I_reflejada);title('Imagen reflejada')
subplot(325);imshow(I_volteada);title('Imagen de cabeza')

