clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 9:Seleccione una imagen binaria que tenga objetos con agujeros 
%y aplíquele el comandoimfill para rellenarlos. Pruebe también el comando
%imclearborder para eliminar objetostocando los bordes de la imagen.

%Explicacion del tema : 
%{
Rellenado de regiones (agujeros) :  O =imfill(I,'holes');
Eliminacion de objetos que tocan los bordes de la imagen : 
O=imclearborder(I,conn)
el parametro conn puede ser 4 u 8 (default)
%}


I = imread('donas.tif');

O_fill=imfill(I,'holes');
O_clear=imclearborder(O_fill);

figure
subplot(1,3,1);imshow(I);title('Imagen original');
subplot(1,3,2);imshow(O_fill);title('Imagen con imfill');
subplot(1,3,3);imshow(O_clear);title('Imagen con imfill + imclearborder');

