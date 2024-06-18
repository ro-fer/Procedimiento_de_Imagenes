function O = filtro_mediana_adaptativo( I, Smax )
%FILTRO_MEDIANA_ADAPTATIVO 
O = zeros(size(l));
P = false(size(l)); %matriz l�gica (me indica si un pixel fue o no procesado), false = cero, true = 1.

% Ordena los datos dentro de la venta para luego buscar el m�nimo o el m�ximo de cada ventana.
% La ventana se mueve recorriendo cada pixel de la imagen.
% Completa usando simetr�a cuando es necesario.

for k = 3:2:Smax
Zmin = ordfilt2(I,1,ones(k),'symmetric');%busca el m�nimo dentro de la ventana kxk
Zmax = ordfilt2(I,k*k,ones(k),'symmetric'); %busca el m�ximo (kxk) dentro de la venta
Zmed = medfilt2(I,[k k],'symmetric');

nivelA= (Zmed > Zmin)&(Zmax > Zmed)& ~P; % ~P (si el pixel no fue procesado),si cumplen, el pixel vale 1
    nivelB = (I > Zmin) & (I < Zmax);
    
    outZxy = nivelA & nivelB;   %donde se cumpla nivelA y nivelB, habr� un 1
    outZmed = nivelA & ~nivelB; %donde se cumpla nivel A y no se cumpla nivel B, habr� 1
	
    O(outZxy) = I(outZxy);
    O(outZmed) = Zmed(outZmed);
    
    P = P | nivelA; %actualizo matriz P
    
    if all(P(:)) %si ning�n pixel es cero --> si ya se analizaron todos los p�xeles
        break;
    end    
end

O(~P) = Zmed(~P); %cuado el tama�o de la ventana no pueda crecer m�s, 
%s�lo quedan los no procesados..
end

