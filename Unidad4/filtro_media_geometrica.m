function v = filtro_media_geometrica( A )
%FILTRO_MEDIA_GEOMETRICA suaviza la imagen con menor p�rdida de detalles que la media aritm�tica 
%(filtro pasa bajo). Apropiado para el ruido Gaussiano, pero falla con el ruido impulsivo.
    mn=size(A,1);
    v=prod(A).^(1/mn);
end

