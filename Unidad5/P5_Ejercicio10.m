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
% Definir el tamaño de la imagen
tamano_imagen = [500, 500];

% Crear un fondo negro
I = zeros(tamano_imagen);

% Definir parámetros de los círculos
radios = [20, 40, 60]; % Diferentes radios para los círculos
centros = [100, 100; 300, 150; 200, 300; 400, 400; 150, 400]; % Centros de los círculos

% Dibujar círculos en la imagen
for i = 1:length(centros)
    [x, y] = meshgrid(1:tamano_imagen(2), 1:tamano_imagen(1));
    circulo = sqrt((x - centros(i,1)).^2 + (y - centros(i,2)).^2) <= radios(mod(i-1, length(radios)) + 1);
    I(circulo) = 1;
end
%binarizacion
u=graythresh(I);
BW=im2bw(I,u);
%BW=imbinarize(I); %otsu, umbral global --> esto para versiones nuevas
[L, n] =bwlabel(BW); % por default 8 -> objetos + el fondo
A=label2rgb(L);

figure
subplot(131);imshow(I);title('Imagen original');
subplot(132);imshow(BW);title('Imagen binarizada');
subplot(133);imshow(A);title('Imagen etiquetada');

s=regionprops(L,'all'); %propiedades de los objetos detectados
areas=cat(1,s.Area); %me muestra en un vector todas las areas de los circulos


figure;
hist(areas, unique(areas)); % Crear un histograma con valores de área únicos
title('Histograma de Áreas de los Círculos');
xlabel('Área');
ylabel('Frecuencia');

