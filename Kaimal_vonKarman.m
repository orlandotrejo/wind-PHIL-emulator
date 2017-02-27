% Dibujar el espectro de Kaimal vs. von Karman
% Entrada, una velocidad del viento promedio en una hora (U) y (h) altitud

h = 60;
U = 10;

Lu2 = 0.3048*h/((0.0539+0.25e-3*h)^1.2);

n = 0.0001:1e-5:1;

Su = zeros(1,length(n));

for i=1:length(n)

Su(i) = 4*n(i)*Lu2/U/((1+70.8*(n(i)*Lu2/U)^2)^(5/6));

end

semilogx (n,Su)