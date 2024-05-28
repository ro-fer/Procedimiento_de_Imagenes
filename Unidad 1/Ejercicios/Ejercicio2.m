%% Datos grales
clear all
close all
clc
%%Graficar las siguientes superficies utilizando los comandos surf y mesh.
%%Use diferentes mapas de colores en cada supercie.


%superficie 1
[x1,y1] = meshgrid(-5:0.5:5);
z1 = x1.^2+y1.^2;
%superficie 2
[x2,y2] = meshgrid(-8:0.5:8);
z2 = sin(sqrt(x2.^2+y2.^2))./(sqrt(x2.^2+y2.^2));

%Con mesh

figure,
subplot(2,1,1);
mesh(x1,y1,z1)
title('Sumas de cuadrados')
colormap(pink(256))
subplot(2,1,2);
mesh(x2,y2,z2)
title('Senoideal')


%Con surf

figure,
subplot(2,1,1);
surf(x1,y1,z1)
title('Sumas de cuadrados')
subplot(2,1,2);
surf(x2,y2,z2)
title('Senoideal')