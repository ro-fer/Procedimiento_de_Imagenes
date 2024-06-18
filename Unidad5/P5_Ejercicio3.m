clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 3 : Genere una imagen binaria compuesta por lineas (de distinta
%%orientacion) y circulos de color blanco sobre un fondo negro. Aplique una
%%operacion morfologica apropiada para separar los curculos de las lineas

%usare imagen ya hecha
%Op Morf : Apertura y Cierre
I = imread('circulos_lineas.png'); %Imagen BW
figure;imshow(I);title('Imagen original')
%imtool(I) %Me sirve para medir!
%Obs: diametro circulos: 16 px, espesor de las lineas 8-10 px
I=im2double(rgb2gray(I));
se=strel('disk',8); %radio : 8 ; diametro 16
Id = imopen(I,se); %elimina los objetos mas chicos que el SE
%figure;imshow(Id);title('Imagen sin lineas')

%contar circulos
[L,n]=bwlabel(Id); % a cada objeto le da un nro
s=regionprops(L,'all'); %propiedades de los objetos detectados
areas=cat(1,s.Area); %me muestra en un vector todas las areas de los circulos
A=label2rgb(L);%le da un color diferente a cada objeto

figure
subplot(131);imshow(I);title('Imagen original')
subplot(132);imshow(Id);title('Imagen con apertura')
subplot(133);imshow(I-Id);title('Imagen con apertura - Imagen original')

figure;imshow(L);
figure;imshow(A);