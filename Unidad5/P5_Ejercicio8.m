clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 8:Determine la frontera de los objetos en una imagen usando 
%la formula y el comando bwperim.


I = imread('busto.tif');

O=bwperim(I);

figure
subplot(1,2,1);imshow(I);title('Imagen original');
subplot(1,2,2);imshow(O);title('Frontera con bwperim');


