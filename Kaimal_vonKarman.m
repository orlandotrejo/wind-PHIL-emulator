% Dibujar el espectro de Kaimal vs. Von Karman
% Corresponden a la descripción estadística de las turbulencias
% ENTRADAS: velocidad del viento promedio en una hora (U) y altitud (h)
% LIMITACIONES: Solo la componente longitudinal

h = 60;
U = 10;

Lu2 = 0.3048*h/((0.0539+0.25e-3*h)^1.2);
Lu1 = 2.329*Lu2;

n = 0.0001:1e-5:1;

SuV = zeros(1,length(n)); %Espectro de Von Karman
SuK = zeros(1,length(n)); %Espectro de Kaimal

for i=1:length(n)

SuV(i) = 4*n(i)*Lu2/U/((1+70.8*(n(i)*Lu2/U)^2)^(5/6));
SuK(i) = 4*n(i)*Lu1/U/((1+6*(n(i)*Lu1/U))^(5/3));

end

semilogx (n,SuV)
hold on
semilogx (n,SuK,'r')

xlabel('Frecuencia [Hz]')
ylabel('Espectro Normalizado')

legend('Von Karman','Kaimal')
title('Comparación de espectros de turbulencia a 10 m/s y 60 m')

hold off