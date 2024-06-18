function v = filtro_media_armonica( A )
%FILTRO_MEDIA_ARMONICA apropiado para ruido sal, falla para ruido pimienta. Trabaja bien con ruido
%Gaussiano, preservando detalles de la imagen.
mn = size (A,1);
v = mn./sum(1./(A+eps));
end

