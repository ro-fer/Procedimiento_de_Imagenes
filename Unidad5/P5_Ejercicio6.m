clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 6: Aplique la transformación hit-or-miss a una imagen binaria, 
%%definiendo un par de elementos estructurales (o la matriz intervalo) de tal forma que
%%permita detectar un patrón especifico.

% Explicacion hit-or-miss
%{
C=bwhitmiss(A,B1,B2) ; % Resulta en todas las ubicaciones de A que coincidad con 
%los pixeles de B1 (hit) y que no coincidan con B2 (miss)

Hay una alternativa : 
C=bwhitmiss(A,B);
Donde B=matriz intervalo ; B=1 donde B1=1 ; B=-1  donde B2=1 ; B=0 en el
resto

%} 

%Genero una matriz con forma de cruz
A = [ 0 0 0 0 0 0;
    0 0 1 1 0 0;
    0 1 1 1 1 0;
    0 1 1 1 1 0;
    0 0 1 1 0 0;
    0 0 0 0 0 0];


B = [ 0 -1 -1;
    1 1 -1;
    0 1 0] ; % matriz intervalo
%figure;colormap(gray(2));imagesc(B);
C = bwhitmiss(A,B);

figure
subplot(121);colormap(gray(2));imagesc(A);title('A');
subplot(122);colormap(gray(2));imagesc(C);;title('C : aplicando B "matriz intervalo" ');

%Ahora usando B1 y B2
X1 = [0 0 0;
     1 1 0;
     0 1 0];

 B1=strel('arbitrary',X1);
 X2 = [0 1 1;
     0 0 1;
     0 0 0];

 B2=strel('arbitrary',X2);
 C2 = bwhitmiss(A,B1,B2);

figure
subplot(121);colormap(gray(2));imagesc(A);title('A');
subplot(122);colormap(gray(2));imagesc(C2);;title('C : aplicando B1 y B2');

%% Transformacion Hit-or-Miss usando look-up tables 

%Aplica la esqueletizacion hasta que no haya mas cambios
I=imread('hueso.tif');
Ie=bwmorph(I,'skel',inf);

figure
subplot(1,2,1);imshow(I);title('Imagen original');
subplot(1,2,2);imshow(Ie);title('Equeletizacion');

%Determina los puntos extremos (end-points) de una imafen binaria
%La imgen de salida será binaria y en blanco tendrá los extremos sobre
%fondo negro
lut=makelut(@endpoint_fcn,3); %vecindad 3*3
O=applylut(Ie,lut);
 
figure
subplot(1,3,1);imshow(I);title('Imagen original');
subplot(1,3,2);imshow(Ie);title('Equeletizacion');
subplot(1,3,3);imshow(O);title('Puntos extremos');
