function v= filtro_media_contra_armonica( A,Q )
%FILTRO_MEDIA_CONTRA_ARMONICA apropiado para ruido sal y pimienta. Q es el orden del filtro, si Q>0 elimina
%pimienta, si Q<0 elimina la sal, si Q=0 media aritm�tica, Q=-1 media arm�nica.
v=sum(A.^(Q+1))./sum(A.^[Q);

end

