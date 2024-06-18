clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 5 : Abra una imagen compuesta por un texto. Seleccione un
%%caracter dentro de la imagen. Determine el SE y la operacion morfologica
%%a aplicar para identificar ese caracter y contar su ocurrencia en el
%%texto.

I = imread('letras.png'); %Imagen
figure;imshow(I);title('Imagen original')
%imtool(I) %Me sirve para medir!
I=im2double(rgb2gray(I));

%Buscare contar "e"
zoom;pause;

[x,y]=ginput(2); %devuelve los dos puntos seleccionados con el mouse
x=round(x); %redondeo
y=round(y);
ancho=abs(x(2)-x(1));
alto=abs(y(2)-y(1));
hold on
rectangle('Position',[min(x),min(y),ancho,alto],'Edgecolor','r');

I=imcomplement(I); %sigue siendo grayscale
%I=not(I); %pasa a ser Bw
A=imcrop(I,[min(x) min(y) ancho alto]);
%figure;imagesc(A);colormap(gray(256));
%genero matriz binaria X a partir de A
X=ones(size(A));
ix=find(A==0);
X(ix)=0;

SE=strel('arbitrary',X,A); %A le da altura a cada miembro del SE 
%SE=strel('arbitrary',A); %si I es BW, SE siempre plano

C=imopen(I,SE);

figure
subplot(121);imshow(I);title('Imagen original');
subplot(122);imshow(C);title('SE');

%{ 
[L,n]=bwlabel(C); % a cada objeto le da un nro
s=regionprops(L,'all'); %propiedades de los objetos detectados
areas=cat(1,s.Area); %me muestra en un vector todas las areas de los circulos
A=label2rgb(L);%le da un color diferente a cada objeto

figure;imshow(L);
figure;imshow(A);
%}

