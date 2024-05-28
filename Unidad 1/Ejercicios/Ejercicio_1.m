%% Datos grales
clear all
close all
clc

A =zeros(10);
[f,c]= size(A);
for col=1:c
    for fil=1:f
       if rem(fil,2) ==0
           if rem(col,2) ==1
                A(fil,col) =256;
                
           end
       else
           if rem(col,2) ==0
                A(fil,col) =256;
                
           end
       end
       
    end

end
figure
colormap(gray(256));
image(A)

