%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio 4 : Abra una imagen y aplique diferentes tipos de filtros
%modificando el tamaño del kernel


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
b1=3;
b2=7;
b3=11;
FB1 = ones(b1)/(b1*b1); %3x3
FB2= ones(b2)/(b2*b2); %5x5
FB3 = ones(b3)/(b3*b3); %11x11

%Filtro Pasa altos
a1=3;
a2=5;
a3=11;
FA1 =ones(a1);FA1(3,3)=-a1;FA1=-FA1;
FA2 =ones(a2);FA2(3,3)=-a2;FA2=-FA2;
FA3 =ones(a3);FA3(3,3)=-a3;FA3=-FA3;


%
OFB1 = conv2(I,FB1);
OFB2 = conv2(I,FB2);
OFB3 = conv2(I,FB3);
OFA1 = conv2(I,FA1);
OFA2 = conv2(I,FA2);
OFA3 = conv2(I,FA3);

figure()
subplot(221);imshow(I);title('Imagen Original')
subplot(222);imshow(OFA1);title(['Imagen con Filtro Altos : ',num2str(a1),' X ',num2str(a1)])
subplot(223);imshow(OFA2);title(['Imagen con Filtro Altos : ',num2str(a2),' X ',num2str(a1)])
subplot(224);imshow(OFA3);title(['Imagen con Filtro Altos : ',num2str(a3),' X ',num2str(a3)])

figure()
subplot(221);imshow(I);title('Imagen Original')
subplot(222);imshow(OFB1);title(['Imagen con Filtro Bajos : ',num2str(b1),' X ',num2str(b1)])
subplot(223);imshow(OFB2);title(['Imagen con Filtro Bajos : ',num2str(b2),' X ',num2str(b2)])
subplot(224);imshow(OFB3);title(['Imagen con Filtro Bajos : ',num2str(b3),' X ',num2str(b3)])
