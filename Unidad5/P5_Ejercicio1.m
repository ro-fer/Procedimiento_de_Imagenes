clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 1: Genere diferentes elementos estructurales (SE) emplenado la
%%funcion strel

%diamante
tipo='Diamante';
r=2;
se1= strel('diamond',r);
A = getnhood(se1);  % Obtener la vecindad debido a version 2014 de Matlab
%Deberia de poder hacerlo a partir de A=se1.Neighborhood
figure;colormap(gray(2));imshow(A, 'InitialMagnification', 'fit');
title(['Elemento estructural : ',tipo]);

%disco
tipo='Disco';
radio=7;
n=0;
%strel('disk',r,n) ; r: radio ; n: especifica el número...
%de elementos estructurantes de línea utilizados para aproximar el disco
se2= strel('disk',radio,n) ;
B = getnhood(se2);  % Obtener la vecindad debido a version 2014 de Matlab
%Deberia de poder hacerlo a partir de A=se1.Neighborhood
figure;colormap(gray(2));imshow(B, 'InitialMagnification', 'fit');
title(['Elemento estructural : ',tipo]);

%Linea
tipo='Linea'; %Longitud len, ángulo deg [grados] medido desde el eje x en sentido antihorario.
len=5; deg=45;
se3= strel('line',len,deg);
C = getnhood(se3);  % Obtener la vecindad debido a version 2014 de Matlab
%Deberia de poder hacerlo a partir de A=se1.Neighborhood
figure;colormap(gray(2));imshow(C, 'InitialMagnification', 'fit');
title(['Elemento estructural : ',tipo]);

%Rectangulo
tipo='Rectangulo'; %MN es el tamaño (vector de dos elementos enteros positivos).
MN=[2 3];
se4= strel ('rectangle',MN);
D = getnhood(se4);  % Obtener la vecindad debido a version 2014 de Matlab
figure;colormap(gray(2));imshow(D, 'InitialMagnification', 'fit');
title(['Elemento estructural : ',tipo]);

%Cuadrado
tipo='Cuadrado'; %W es el ancho en píxeles( enteros positivos).
W=5;
se5= strel ('square',W);
E = getnhood(se5);  % Obtener la vecindad debido a version 2014 de Matlab
figure;colormap(gray(2));imshow(E, 'InitialMagnification', 'fit');
title(['Elemento estructural : ',tipo]);

%Arbitraria
tipo='Arbitraria'; %NHOOD es una matriz de 0 y 1 que especifica la forma.
NHOOD=[0 1 0; 1 0 1 ; 0 1 0];
se6= strel ('arbitrary',NHOOD);
F = getnhood(se6);  % Obtener la vecindad debido a version 2014 de Matlab
figure;colormap(gray(2));imshow(F, 'InitialMagnification', 'fit');
title(['Elemento estructural : ',tipo]);
