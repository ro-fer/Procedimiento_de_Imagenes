%TP1, Ej1.14: Fusionar 2 imagenes  usando operaciones aritmeticas y
%booleanas
clc;close all;clear all


clc; close all; clear all; 

%Selecciono y abro dos imágenes 
A = rgb2gray(imread('BW1.png')); 
B = rgb2gray(imread('BW2.png'));

%calculo el umbral(Otsu)
u1 = graythresh(A); 
u2 = graythresh(B); 

%binarizo
A_b = im2bw(A,u1); 
B_b = im2bw(B,u2); 

[f1,c1] = size(A_b); 
[f2,c2] = size(B_b);

%modifico resolucion espacial 
fil = min([f1, f2]); 
col = min([c1, c2]); 

An = imresize(A_b, [fil col]); 
Bn = imresize(B_b, [fil col]); 


figure
subplot(221); imshow(A); title('Imagen A'); 
subplot(222); imshow(B); title('Imagen B'); 
subplot(223); imshow(An); title('Imagen A binarizada y re-muestreada'); 
subplot(224); imshow(Bn); title('Imagen B binarizada y re-muestreada'); 

% operaciones logicas 
R0 = not(An); 
R1 = and(An,Bn); 
%R1 = An & Bn; 

R2 = or(An,Bn); 
%R2 = An | Bn; 

R3 = xor(An,Bn); 

figure
subplot(221); imshow(R0); title('Not A'); 
subplot(222); imshow(R1); title('A and B'); 
subplot(223); imshow(R2); title('A or B'); 
subplot(224); imshow(R3); title('A xor B'); 