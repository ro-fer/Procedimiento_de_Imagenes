close all, clear all, clc
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
[N, M] = size(I);
u=128;
Isimple=I;
Idoble=I;
ui=40;
us=200;
for i=1:N
    for j=1:M
       if I(i,j)>u
           Isimple(i,j)=250;
       else
           Isimple(i,j)=0;
       end
       
    end
end
for i=1:N
    for j=1:M
       if I(i,j)>ui &  I(i,j)<us
           Idoble(i,j)=250;
       else
           Idoble(i,j)=0;
       end
       
    end
end

figure
subplot(2,1,1)
imshow(I, [0 255]);colorbar;
title('Imagen normal')
subplot(2,1,2)
imshow(Isimple, [0 255]);colorbar;
title('Imagen umbralizado simple')


figure
subplot(2,1,1)
imshow(I, [0 255]);colorbar;
title('Imagen normal')
subplot(2,1,2)
imshow(Idoble, [0 255]);colorbar;
title('Imagen umbralizado doble')