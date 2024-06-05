%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio 6 : Abra una imagen y aplique filtroa de movimiento

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

l1=20;
t1=45;
l2=20;
t2=90;

FM1=fspecial('motion',l1,t1);
FM2=fspecial('motion',l2,t2);

OFM1 = conv2(I,FM1);
OFM2 = conv2(I,FM2);

figure()
subplot(131);imshow(I);title('Imagen Original')
subplot(132);imshow(OFM1);title(['Imagen con Filtro Motion, len: ',num2str(l1),', theta:  ',num2str(t1)])
subplot(133);imshow(OFM2);title(['Imagen con Filtro Motion, len: ',num2str(l2),' , theta: ',num2str(t2)])