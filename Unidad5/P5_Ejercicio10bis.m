clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 10
%{
Genere una imagen con fondo negro y círculos blancos de diferentes tamaños.
Aplique el comando bwlabel para identificar los diferentes objetos.
Calcule el área y las coordenadas del centroide de cada figura geométrica 
empleando el comando regionprops. Genere un histograma con la información
 de cuantos círculos de cada tamaño hay en la imagen.
%}
I = imread('letras_objetos.bmp');
I=rgb2gray(I);
%binarizacion
u=graythresh(I);
BW=im2bw(I,u);
%BW=imbinarize(I); %otsu, umbral global --> esto para versiones nuevas
[L, n] =bwlabel(BW); % por default 8 -> n=11 porque detecta 10 objetos + el fondo
A=label2rgb(L);

figure
subplot(131);imshow(I);title('Imagen original');
subplot(132);imshow(BW);title('Imagen original');
subplot(133);imshow(A);title('Imagen original');


