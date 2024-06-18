function v = filtro_media_recortado(A,d)
%FILTRO_MEDIA_RECORTADO  : d debe ser positivo, entero y par
aux= sort(A); %Ordena los elementos de cada columna de menor a mayor
auxr= ax((d/2)+1:end-(d/2),;); %elimina los extremos
v=mean (auxr); % calcula promedio de cada columna
end
