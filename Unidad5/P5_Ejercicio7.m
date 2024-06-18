clc; clear all; close all; 
%%Practica 5: Procesamiento morfologico
%%Ejercicio 7: Aplique diferentes procesamientos morfológicos a una imagen
%%binaria, utilizando el comando bwmorph.
%Explicacion de BWMORP
%{ 
I: imagen de entrada binaria
Operacion: especifica el tipo de operacion
%{
'bothat' : sustrae la imagen de entrada de su cierre
'bridge' conecta píxeles separados por un gap (huevo, vacío) de un único pixel
'clean': remueve pixeles aislados ( un 1 rodeado de 0s)
'branchpoints': encuentra los puntos de ramificación (branch) de un esqueleto
'endpoints': encuentra los puntos extremos de un esqueleto.
'remove': remueve pixeles interiores
'shrink': encoge, contrae, reduce objetos sin agujero a puntos y objetos con agujeros a anillos.
'skel': esqueletoniza una imagen
'spur': remueve puntos extremos (endpoint) de líneas sin remover completamente pequeños objetos
'thin': reducen los objetos sin agujeros a un trazo de un pixel (si N=inf).
'majority': setea un pixel a 1 si 5 o más pixeles en una vecindad 3x3 son 1s, en otro caso vale 0.
'close': cierre 3x3
'open': apertura 3x3
'dilate': dilatación 3x3
'erode': erosión 3x3
'fill': rellena agujeros de único pixel (pixel 0 rodeado de 1s)
'bothat': sustrae la imagen de entrada de su cierre
'hbreak': remueve píxeles conectados con forma de H

%}
n : Nro de veces que se repite (default n=1)
%}
%O = bwmorph (I, operacion, n) ; 

I1 = imread('huella.tif');
Ie1=bwmorph(I1,'skel');
Ie12=bwmorph(Ie1,'skel');
figure
subplot(1,3,1);imshow(I1);title('Huella digital');
subplot(1,3,2);imshow(Ie1);title('Adelgazo una vez');
subplot(1,3,3);imshow(Ie12);title('Adelgazo nuevamente');

I2=imread('hueso.tif');
Ie2=bwmorph(I2,'skel',inf);
Ip2=bwmorph(Ie2,'spur',10);

figure
subplot(1,3,1);imshow(I2);title('Imagen original');
subplot(1,3,2);imshow(Ie2);title('Equeletizacion');
subplot(1,3,3);imshow(Ip2);title('Poda (pruning) '); 

%Adelgazamiento <--> deteccion de fronteras
It2=bwmorph(I2,'erode',2); %aplico 2 veces el operador, obtengo un borde de 2 pixeles de espesor

figure
subplot(1,2,1);imshow(I2);title('Imagen original');
subplot(1,2,2);imshow(I2-It2);title('Frontera');