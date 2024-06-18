clc; clear all; close all; 
%%Practica 4: Degradacion y restauracion de imagenes
%%Ejercicio 4: Degrade una imagen aplicandole el filtro 'motion' con la
%%funcion fspecial. Implemente un filtro inverso. Visualice los resultados
%%del filtrado comparando con la imagen original

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

%Simulo el movimiento
LEN=20; THETA =45;
PSF = fspecial('motion',LEN,THETA); %Point - spread function
Imov=imfilter(I,PSF,'conv','circular');


%Restauro asumiendo que no hay ruido
estimated_nsr=0; %relacion de potencial ruid/señal (ruido aditivo)

%como NSR=0 tenemos filtro inverso ideal
wnr = deconvwnr(Imov,PSF,estimated_nsr);

figure()
subplot(1,3,1);imshow(I);title('Imagen Original')
subplot(1,3,2);imshow(Imov);title('Imagen corrida ' )
subplot(1,3,3);imshow(wnr );title('Restauracion imagen movida,considero ruido =0 ')


%Sumo ruido gaussiano a la imagen movida
noise_mean=0;
noise_var=0.0001;
Imov_n=imnoise(Imov,'gaussian',noise_mean,noise_var);
%Prueba 1
%Resturo asumiendo que no hay ruido 
estimated_nsr=0; %relacion de potencial ruid/señal (ruido aditivo)
wnr2 = deconvwnr(Imov_n,PSF,estimated_nsr);

figure()
subplot(1,3,1);imshow(I);title('Imagen Original')
subplot(1,3,2);imshow(Imov_n);title('Imagen corrida y con ruido gaussiano ' )
subplot(1,3,3);imshow( wnr2);title('Restauracion imagen movida,considero ruido =0 ')

%Prueba 2

%Restauro usando un mejor estimador de la NSR
estimated_nsr= noise_var  / var(I(:));
wnr3 = deconvwnr(Imov_n,PSF,estimated_nsr);

figure()
subplot(1,2,1);imshow(I);title('Imagen Original')
subplot(1,2,2);imshow( wnr3);title('Restauracion imagen estimando NSR')

%itero buscando el mejor parametro K
K=0.001:0.001:0.01;

figure
for i=1:10
    wnr4 = deconvwnr(Imov_n, PSF, K(i));
    subplot(2,5,i);imshow(wnr4,[]);
    title(['K= ',num2str(K(i))]);
end
%Prueba 3 : conozco el espector de potencia del ruido y de la imangen
noise_mean=0.1;
noise_var=0.001;
sigma=sqrt(noise_var);

%genero los n° aleatorios con distribucion gaussiana de media noise_mean y
%desvio sigma
R=noise_mean+sigma*randn(M,N);
Imov_n=Imov+ R;

SN=(abs(fft2(R))).^2;%espectro de potencia del ruido
SI=(abs(fft2(I))).^2;%espectro de potencia de la imagen original
NSR=SN./SI; %relacion de potencia ruido/señal

wnr5=deconvwnr(Imov_n,PSF,NSR);

figure()
subplot(1,3,1);imshow(I);title('Imagen Original')
subplot(1,3,2);imshow(Imov_n);title('Imagen corrida y con ruido gaussiano ' )
subplot(1,3,3);imshow( wnr5);title('Restauracion calculando la NSR de espectros de potencia')



