function A = vecindad_LUT(M,N)
%VECINDAD_LUT  : Genero la matriz para aplicar Look-up tables
A=zeros(M,N);
cont=0;
for i=1:M
    for j=1:N
        A(j,i)=2^(cont);
       cont=cont+1;
    end
     
end

