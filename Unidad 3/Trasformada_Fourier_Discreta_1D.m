clc; clear all; close all; 
% Calcule y grafique el espectro de magnitud de la suma de dos
% sinusoides (utilice el algoritmo fft de matlab)

f1 = 2; %Hz
f2 = 10; %Hz
fs = 20 * f2; %Frecuencia de muestreo cumple con Teorema de Nyquist
tm =1/fs; %periodo de muestreo (paso)

t = 0 : tm : 2*pi;  %eje temporal
N = length(t); 
f = -fs/2 : fs/N : fs/2 - fs/N; %vector frecuencias para la DFT

y1 =  4 * sin(2*pi*f1*t); 
y2 =  1.5 * sin(2*pi*f2*t); 
yt = y1 + y2; 

tfyt = fft(yt); %% Transformada de Fourier Discreta DFT-1D
%fftshift centro espectro
figure
subplot(2,1,1);plot(t,yt);title('Suma de las señales senoidales (2 y 10 Hz) '),xlabel('Tiempo (seg)'),ylabel('Amplitud');axis tight;
subplot(2,1,2);plot(f,fftshift(abs(tfyt))); title ('Espectro de magnitud'),xlabel('Frecuencia (Hz)'),ylabel('Magnitud');axis tight;


%%Ejercicio 2
% A la señal del punto 1, agreguele ruido aleatorio y observe como se
% modifica su espectro de magnitud

r = rand(1, length(y1)) * 2; 
rm=mean(r);
ruido =r - rm;
yt = y1 + y2 + ruido; 
tfyt = fft(yt); 

y1ruido= y1 + ruido;
y1_tfyt =fft(y1ruido);

y2ruido= y2 + ruido;
y2_tfyt =fft(y2ruido);

figure
subplot(2,2,1);plot(t,y1ruido);title('Señal senoidal 1 con ruido aleatorio'),xlabel('Tiempo (seg)'),ylabel('Amplitud');axis tight
subplot(2,2,2);plot(f,fftshift(abs(y1_tfyt))); title ('Espectro de magnitud de la señal senoideal con ruido aleatorio.'),xlabel('Frecuencia (Hz)'),ylabel('Magnitud');axis tight
subplot(2,2,3);plot(t,y2ruido);title('Señal senoidal  2 con ruido aleatorio'),xlabel('Tiempo (seg)'),ylabel('Amplitud');axis tight
subplot(2,2,4);plot(f,fftshift(abs(y2_tfyt))); title ('Espectro de magnitud de la señal senoideal con ruido aleatorio.'),xlabel('Frecuencia (Hz)'),ylabel('Magnitud');axis tight




figure
subplot(2,1,1);plot(t,yt);title('Suma de las señales senoidal con ruido aleatorio'),xlabel('Tiempo (seg)'),ylabel('Amplitud');axis tight
subplot(2,1,2);plot(f,fftshift(abs(tfyt))); title ('Espectro de magnitud de la señal senoideal con ruido aleatorio.'),xlabel('Frecuencia (Hz)'),ylabel('Magnitud');axis tight



%% Ejercicio 3 
%A la señal del punto 2, apliquele un filtro pasa bajos frecuencial.
%Antitransforme y visualice los resultados.
%¿Filtro pasa banda???
%Genero el filtro dejando pasar los valores de f1 pero no los de f2
% |f1| = 3 y |f2|= 10 por lo cual pongo como valor intermedio 5 y -5
for i=1:N
    if(f(i)>-5) && (f(i)<5)
        H(i)=1;
    else
        H(i)=0;
    end
end

%DFT, filtrado frecuencial y DFT-1
trafo = fft(yt);%transformada "cruda" y "descentrada"
p=trafo.*ifftshift(H);%filtrado frecuencial
o=real(ifft(p));%anti-transformada

%v= tfys. * H ; %filtrado "centrado" para visualizar

figure()
plot(t,y1,'r',t,o,'bx');legend('y1 original','y1 recuperada')


%%Ejercicio 4
%A la señal del punto 2, apliquele un filtro pasa bajos espacial.
% Voy a volver a copiar valores dados por docente clase 17-04-24
frec=1;
w=2*pi*frec;
fm=20*frec;

t=0:1/fm:2*pi;%dominio temporal
N=length(t); %nº de elementos
f=-fm/2:fm/N:fm/2-fm/N;%eje frecuencial

y=4*sin(w*t);
r=rand(size(y))*2;
ruido=r-mean(r);
yr=y+ruido;

%defino filtro en el dominio temporal
h=ones(1,5)/5;%filtro pasa bajo
o=conv(yr,h,'same');

tfy=fftshift(abs(y));
tfyr=fftshift(abs(yr));
tfo=fftshift(abs(o));

figure()

subplot(321);plot(t,y);axis tight; title('Señal original')
subplot(322);plot(f,tfy/N);axis tight
subplot(323);plot(t,yr);axis tight; title('Señal con ruido')
subplot(324);plot(f,tfyr/N);axis tight
subplot(325);plot(t,o);axis tight; title('Señal con ruido filtrada PB 1x5')
subplot(326);plot(t,tfo/N);axis tight