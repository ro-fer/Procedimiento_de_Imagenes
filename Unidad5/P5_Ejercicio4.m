clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 4 : Genere una imagen binaria compuesta por lineas
%%verticales,horizontales y oblicuas. Aplique una operacion morfologica
%%adecuada para separar las lineas H y V
%Op Morf : Apertura y Cierre
I = imread('lineasVH.png'); %Imagen BW
figure;imshow(I);title('Imagen original')
%imtool(I) %Me sirve para medir!
%Obs: diametro circulos: 16 px, espesor de las lineas 8-10 px
I=im2double(rgb2gray(I));

se1=strel('rectangle',[7 16]); %horizontal
se2=strel('rectangle',[16 7]); %vertical

Id1=imopen(I,se1);
Id2=imopen(I,se2);

figure
subplot(131);imshow(I);title('Imagen original')
subplot(132);imshow(Id1);title('Imagen lineas horizontales')
subplot(133);imshow(Id2);title('Imagen lineas verticales')
