clc; clear all; close all; 
%%Practica 4: Degradacion y restauracion de imagenes
%%Ejercicio 3: Genere ruido periodico y apliquele un filtro en el dominio
%%frecuencia de tipo Notchh rechaza banda. Visualice los espectros de
%%magnitud del filtro, de la imagen con ruido y de la imagen filtrada. 

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
%.......................................................................
%Redimensiono la imagen para que luego el filtro notch no tenga problemas,
%Ambas dimensiones deben ser impar
%...
%Calcula la DFT2D "Cruda"
T=fft2(I);
%..
%Genero ruido periodico : defino las coordenadas de los impulsos (eje horiz
%=V y ver = U) 
C=[0 10; 30 30]; % matriz con las coordenadas  (u , v) de cada delta [u0 v0 ; u1 v1]
A= [100;100] %amplitudes

%r : patron espacial, R: espectro crudo centrado ; S: espectro de magnitud
%centrado 

[r,R,S]=imnoise3(M,N,C,A);
%sumo la DFT2 "cruda" de la imagen y la DFT2 "cruda" del ruido (primero la
%"descentro")
TT=T+ifftshift(R);
In = real(ifft2(TT));%calcula la IDFT2

figure
subplot(221);imshow(I);title('Imagen original')
subplot(222);imshow(fftshift(log(abs(T)+1)),[]);title('Espectro de magnitud imagen original')
subplot(223);imshow(In,[]);title('Imagen original + ruido periodico')
subplot(224);imshow(fftshift(log(abs(TT)+1)),[]);title('Espectro de magnitud imagen con ruido')

%...
%Genera filtros Notch (rechaza banda o pasa banda) : ideal , Butterworth o
%Gaussiano
s=menu('Filtros Notch','1) Rechaza banda ideal','2)Rechaza Banda BW','3) RB Gauss',...
    '4) PB Ideal','5)PB BW','6)PB Gauss')

switch s
    case 1 %notch rechaza banda ideal
        D0=input('D0 = ');%radio del filtro expresado en pixeles
        H=filtro_notch_simplificado('ideal','reject',M,N,C,D0); %centrado
        %C(kx2) , k pares de coordenadas (u,v) : definen los centros notch
        %Se especifica solamente una coordenada (u,v) por filtro
        %D0 :radio (frecuencia de corte) de los filtros notcj. Escalar o
        %vertor (1xk)
        %n: orden del filtro BTW
        %Tipo: 'ideal','btw',''gaussian'
        %Notch: 'reject','pass'
        
    case 2 % notch rechaza banda Butterworth de orden n
        D0=input('D0 = ');%radio del filtro expresado en pixeles
        n=input('Orden n del filtro:  ');
        H=filtro_notch_simplificado('btw','reject',M,N,C,D0,n); %centrado
        
    case 3 % notch rechaza banda gaussiano
        D0=input('D0 = ');%radio del filtro expresado en pixeles
        H=filtro_notch_simplificado('gaussian','reject',M,N,C,D0); %centrado
        
    case 4 %notch pasa banda ideal
        D0=input('D0 = ');%radio del filtro expresado en pixeles
        H=filtro_notch_simplificado('ideal','pass',M,N,C,D0); %centrado
        
    case 5 % notch pasa banda Butterworth de orden n
        D0=input('D0 = ');%radio del filtro expresado en pixeles
        n=input('Orden n del filtro:  ');
        H=filtro_notch_simplificado('btw','pass',M,N,C,D0,n); %centrado
    
    case 3 % notch pasa banda gaussiano
        D0=input('D0 = ');%radio del filtro expresado en pixeles
        H=filtro_notch_simplificado('gaussian','pass',M,N,C,D0); %centrado
end

%IMPORTANTE TODOS LOS FILTROS ESTAN CENTRADOS!!

%Para graficar trabajo con datos "centrados" y con "compresion log"
O=fftshift(log(abs(TT)+1));
V=H.*O;
%Para filtrar y anti-transformar trabajo con datos "descentrados y crudos•
prod =ifftshift(H).*TT;
P=real(ifft2(prod));

figure
subplot(2,3,[1 4]);imshow(I,[]); title('lmagen Original')
subplot(2,3,2);imshow(In,[]); title('lmagen con ruido periódico')
subplot(2,3,3);imshow(O,[]);titte('Espectro magnitud imagen ruidosa')
subplot(2,3,5);imshow(P,[]);title('lmagen filtrada')
subplot(2,3,6);imshow(V,[]);title('Espectro magnitud imagen filtrada')

