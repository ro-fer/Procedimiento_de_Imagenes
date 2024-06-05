%TP1, Ej1.14: Fusionar 2 imagenes color  usando operaciones aritmeticas y
%booleanas
clc;close all;clear all


% leo una imagen
I1 = imread('mesquita.png');
I2 = imread('cara.png');



% modifico resolución espacial para que tengan el mismo tamaño 
[f1,c1,p1] = size(I1); 
[f2,c2,p2] = size(I2); 

fil = min([f1 f2]); 
col = min([c1 c2]); 


IA = imresize(I1, [fil col]);
IB = imresize(I2, [fil col]); 
% 
% observo histogramas de la cara para determinar umbral
 %figure
 %subplot(131); imhist(IB(:,:,1)); title('canal R') 
 %subplot(132); imhist(IB(:,:,2)); title('canal G') 
 %subplot(133); imhist(IB(:,:,3)); title('canal B')

% seteo el umbral para hacer la segmentación (separo rostro de fondo) 
u = 200/255; 

% calculo la mascara 
Bx = im2bw(IB,u);  % matriz logica mxn


mask1 = cat(3,Bx,Bx,Bx); % matiz lógica mxnx2, canales RGB
mask2 = not(mask1); % complemento de la mascara

% no se puede graficar una imagen de 3 dimensiones
% la convierto a double 
figure
subplot(121); imshow(double(mask1)); title('Máscara de filtrado'); 
subplot(122); imshow(double(mask2)); title('Negativo de la Máscara de filtrado'); 

S = immultiply(IB, mask2); 
Ax = immultiply(IA, mask1); 

R = imadd(Ax, S); 

figure
subplot(241); imshow(IA); title('Imagen A'); 
subplot(245); imshow(IB); title('Imagen B'); 
subplot(242); imshow(double(mask1)); title('Máscara 1'); 
subplot(246); imshow(double(mask2)); title('Máscara 2'); 
subplot(243); imshow(Ax); title('Imagen A por máscara 1'); 
subplot(247); imshow(S); title('Imagen B por máscara 2'); 
subplot(2,4,[4 8]); imshow(R); title('Imagenes A y B fusionadas'); 
