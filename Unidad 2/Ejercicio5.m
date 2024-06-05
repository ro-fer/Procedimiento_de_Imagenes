%Unidad 2 : Filtrado en el dominio espacial
%Ejercicio 5 : Abra una imagen y aplique filtroa detecta bordes basados en
%primera y segunda derivada

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

%%Primera derivada

%Filtro Sobel
H1=fspecial('sobel');%S
H2=rot90(H1);%E
H3=rot90(H1,2);%N
H4=rot90(H1,3);%O

OH1=conv2(I,H1);
OH2=conv2(I,H2);
OH3=conv2(I,H3);
OH4=conv2(I,H4);

figure()

subplot(3,2,[1,2]);imshow(I);title('Imagen Original')
subplot(3,2,3);imshow(OH1);title('Filtro Sobel 3x3 (S)')
subplot(3,2,4);imshow(OH2);title('Filtro Sobel 3x3 (E)')
subplot(3,2,5);imshow(OH3);title('Filtro Sobel 3x3 (N)')
subplot(3,2,6);imshow(OH4);title('Filtro Sobel 3x3 (O)')


%%Segunda derivada

L4 = [ 0 1 0; 1 -4 1; 0 1 0];
L4bis = -L4;
L8 = ones(3);L8(3,3)=-8;
L8bis =-L8;

OL4=conv2(I,L4);
OL4bis=conv2(I,L4bis);
OL8=conv2(I,L8);
OL8bis=conv2(I,L8bis);

figure()

subplot(3,2,[1,2]);imshow(I);title('Imagen Original')
subplot(3,2,3);imshow(OL4);title('Filtro Laplaciano V4 3x3 ')
subplot(3,2,4);imshow(OL4bis);title('Filtro Laplaciano V4 bis 3x3')
subplot(3,2,5);imshow(OL8);title('Filtro  Laplaciano V8  3x3 ')
subplot(3,2,6);imshow(OL8bis);title('Filtro  Laplaciano V8 bis 3x3')
