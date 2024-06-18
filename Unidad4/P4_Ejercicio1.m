clc; clear all; close all; 
%%Practica 4: Degradacion y restauracion de imagenes
%%Ejercicio 1: Genere ruido Gaussiano, Rayleig, exponencial,uniforme, sal,pimienta, sal
% y pimienta y agreguelo a una imagen. Observar como se degrada la imagen

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


%Menu para ver que tipo de ruido voy a utilizar :/
sel = menu('¿Que tipo de ruido desea aplicar?', '1) Gaussiano', '2) Rayleigh ', '3) Exponencial','4) Uniforme ', '5) Sal', '6) Pimienta', '7) Sal y Pimienta');

switch sel
    case 1 %Gaussiano
        a=input('Ingrese el valor medio [0,1]: ');
        b=input('Ingrese el desvio estandar [0,1]: ');
        R=a+b*rand(M,N);
        IconRuido=I+R; %Sumo la imagen y el ruido
        IconRuido=max(min(IconRuido,1),0);%clampeo la imagen para que queden valores en el rango [0,1]
        tipo = 'Gausiana';
    case 2 %Rayleigh
        a=input('Ingrese el valor de a: ');
        b=input('Ingrese el valor de b [>0]: ');
        R=a+sqrt(-b*log(1-rand(M,N)));
        IconRuido=I+R; %Sumo la imagen y el ruido
        IconRuido=max(min(IconRuido,1),0);%clampeo la imagen para que queden valores en el rango [0,1]
        tipo = 'Rayleigh';
    case 3 %Exponencial
        a=0;
        while a<=0
            a=input('Ingrese el valor de a [>0]: ');
            if a<=0
                fprintf('El parametro debe ser positivo. Vuelva a intentarlo.\n ')
            end
        end
        k=-1/a;
        R=k*log(1-rand(M,N));
        IconRuido = IconRuido + R;
        IconRuido=max(min(IconRuido,1),0);
        tipo = 'Exponencial';
    case 4 %Uniforme
        a=input('Ingrese el valor de a: ');
        b=input('Ingrese el valor de b: ');
        R=a+(b-a)*rand(M,N);
        IconRuido=I+R; %Sumo la imagen y el ruido
        IconRuido=max(min(IconRuido,1),0);
        tipo = 'Uniforme';
    case 5 %Sal
        Pa=input('Ingrese el valor de Pa [0,1]: ');
        Pb=0;
        R = ruido_sal_pimienta (M,N,Pa,Pb);
        IconRuido=I;
        ix=find(R==1);
        IconRuido(ix)=1;
        tipo = 'Sal';
    case 6
        Pa=0;
        Pb=input('Ingrese el valor de Pb [0,1]: ');
        R = ruido_sal_pimienta (M,N,Pa,Pb);
        IconRuido=I;
        ix=find(R==0);
        IconRuido(ix)=0;
        tipo = 'Pimienta';
    case 7
        Pa=input('Ingrese el valor de Pa [0,1]: ');
        Pb=input('Ingrese el valor de Pb [0,1]: ');
        R = ruido_sal_pimienta (M,N,Pa,Pb);
        IconRuido=I;
        ix1=find(R==0);
        IconRuido(ix1)=0;
        ix2=find(R==1);
        IconRuido(ix2)=1;
        tipo = 'Sal y pimienta';
end


figure()
subplot(1,3,1);imshow(I);title('Imagen Original')
subplot(1,3,2);imshow(IconRuido);title(['Imagen con ruido ', tipo])
subplot(1,3,3);hist(R(:),25);title(['Histograma ruido ', tipo])

%%Ejercicio 2: A las imagenes con ruido generadas en el punto anterior, apliquele los diferentes filtros de media, de orden y adaptativos
m =3;
n=3;
sel_filtro = menu ('¿Que tipo de filtro desea aplicar?','1) Media Geometrica',...
'2) Media Armonica', '3)Media contra-armonica','4)Mediana','5) Mínima', '6)Máxima','7)Punto Medio',...
'8) Media Recortador alfa','9) Adaptativo de reduccion de ruido','10) Adaptativo de reduccion de ruido',);
switch sel_filtro
    case 1 %filtro media geometrica
        O = colfilt(IconRuido,[m n],'sliding',@filtro_media_geometrica);
        tipo_filtro = 'Media Geometrica';
    case 2 %Media Armonica
        O = colfilt(IconRuido,[m n],'sliding',@filtro_media_armonica);
        tipo_filtro = 'Media Armonica';
    case 3 %Media contra_armoica 
      Q=input('Ingrese el orden del filtro (Q). Tenga en cuenta que si Q>0 elmina pimienta, si Q<0 elimina la sal, si Q=0 media aritmeerica, Q=-1 media armonica');
      O = colfilt(IconRuido,[m n],'sliding',@filtro_media_contra_armonica,Q);
      tipo_filtro = 'Media Contra Armonica';
    case 4 %mediana
        O=medfilt2(IconRuido,[m n]);
        tipo_filtro = 'Mediana';
    case 5 %minima
        O=colfilt(IconRuido,[m n],'sliding',@filtro_minimo);
        tipo_filtro = 'Minima';
    case 6 %maxima
        O=colfilt(IconRuido,[m n],'sliding',@filtro_maximo);
        tipo_filtro = 'Máxima';
    case 7 % Filtro de punto medio 
        O=(IconRuido,[m n],'sliding',@filtro_punto_medio);
        tipo_filtro = 'Punto Medio';
    case  8 % Filtro media alfa recortado
        d=input('Ingrese el valor de d (alfa). Recuerde que debe ser positivo, entero y par');
        O=filtro_media_recortado(IconRuido,d);
       f tipo_filtro = 'Media Alfa recortado';
    case 9 %Filtro adaptativo de reduccion local de ruido
        var_noise = var(R(:));%varianza del ruido
        O=colfilt(IconRuido,[m n],'sliding',@filtro_adaptativo_reduccion_local_ruido,var_noise); %sigma^2
        tipo_filtro = 'Adaptativo de reduccion local de ruido';
    case 10 % Filtro de mediana adaptativo
        O=filtro_mediana_adaptativo(IconRuido,21); % 21 es el ruido maximo de ventana
        tipo_filtro = 'Adaptativo de mediana';

end
O=max(min(O,1),0); %clampeo los valores de la imagen de salida al intervalo [0,1]
figure()
subplot(1,3,1);imshow(I);title('Imagen Original','FontName','Arial','FontSize',18)
subplot(1,3,2);imshow(IconRuido);title(['Imagen con ruido ', tipo],'FontName','Arial','FontSize',18)
subplot(1,3,3);imshow(O);title(['Imagen filtrada con : ', tipo_filtro],'FontName','Arial','FontSize',18)
