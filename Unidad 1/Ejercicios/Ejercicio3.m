%Guía1 - Ej3 Abrir y graficar un archivo DICOM
clear all,clc,close all

[file,dir]=uigetfile('*.dcm')
filename = [dir,file]
info=dicominfo(filename);

[img,map]=dicomread(filename); %Si las imágenes son grayscale o true-color, map está vacío.
[f,c,p,frames] = size(img) 
% f=filas, c=columnas, p=profundidad o nº de canales, frames = nº de frames del estudio

slide = 60
f1 = img(:,:,:,slide);
max(f1(:))
min(f1(:))

figure(1)
imshow(f1,[])

figure(2)
montage(img,'DisplayRange',[],'Indices',1:180)

figure(3)
montage(img,'DisplayRange',[0 255],'Indices',100:119)

figure(4)
montage(img,'DisplayRange',[0 255],'Indices',100:119,'Size',[2 10]); %size debe incluir a todos los frames

S=zeros(f,c);
img=double(img);

for i=1:frames
    S=S+img(:,:,1,i);
end

figure(5)
imshow(S,[])
title(['Imagen resultante de sumar ', num2str(frames),' frames'])