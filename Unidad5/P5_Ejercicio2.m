clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 2:Aplique el operador dilatacion (imdilate) y el operador
%%erosion (imerode a una imagen binaria. Observar los efectis de aplicar
%%cada operador

% leo una imagen y la convierto a escala de grises
[file,dir] = uigetfile('*.bmp;*.jpg;*.png; *.tif'); %filtro para archivos bmp, jpg y png
filename = [dir,file];
info = imfinfo(filename);
switch info.ColorType
    case 'indexed'
        [Iorig,map] = imread(filename);
        I = ind2gray(Iorig,map); %convierto de indexada a escala de grises

    case 'grayscale'
        I = imread(filename);
        
    case 'truecolor'
        Iorig = imread(filename);
        I=rgb2gray(Iorig); %convierto de RGB a escala de grises       
end
I= im2double(I);
[M,N] = size(I);
%Obs: las imagenes tienen que tener los objetos en blanco (o grises) y el
%fondo en negro
Ic = imcomplement(I);
%Ic =imbinarize(Ic); % si quiero trabajar con BW binarizo la imagen
%grayscale

%Defino el Elemento estructural: forma arbitraria (cruz)
A=[ 0 1 0;
    1 1 1;
    0 1 0];

se=strel('arbitrary', A);
F = getnhood(se);  % Obtener la vecindad debido a version 2014 de Matlab
%si es gray puedo trabajar igual con un SE plano

%Operador dilatacion
Id=imdilate(Ic,se);%por default es 'same', se aplico dos veces el mismmo SE

figure;
subplot(221);imshow(I);title('Imagen original')
subplot(222);imshow(Ic);title('Complemento imagen original')
subplot(2,2,[3 4]);imshow(Id);title('Imagen dilatada 2 veces')


%% erosion
% leo una imagen y la convierto a escala de grises
[file,dir] = uigetfile('*.bmp;*.jpg;*.png; *.tif'); %filtro para archivos bmp, jpg y png
filename = [dir,file];
info = imfinfo(filename);
switch info.ColorType
    case 'indexed'
        [Iorig,map] = imread(filename);
        I = ind2gray(Iorig,map); %convierto de indexada a escala de grises

    case 'grayscale'
        I = imread(filename);
        
    case 'truecolor'
        Iorig = imread(filename);
        I=rgb2gray(Iorig); %convierto de RGB a escala de grises       
end
I= im2double(I);
se2=strel('square',10);
Ie=imerode(I,se2);
Ied=imdilate(Ie,se2);

figure
subplot(131);imshow(I);title('Imagen original')
subplot(132);imshow(Ie);title('Imagen erosionada')
subplot(133);imshow(Ied);title('Imagen erosionada + dilatada')

%Ejemplo 2: circuito

I = imread('circuito.tif'); %Imagen BW
%Defino eleento estructural 
se1= strel('disk',5);
se2= strel('disk',10);
se3= strel('disk',20);

Ie1=imerode(I,se1);
Ie2=imerode(I,se2);
Ie3=imerode(I,se3);
figure
subplot(221);imshow(I);title('Imagen original')
subplot(222);imshow(Ie1);title('Imagen erosionada disco R=5')
subplot(223);imshow(Ie2);title('Imagen erosionada disco R=10')
subplot(224);imshow(Ie3);title('Imagen erosionada disco R=20')
