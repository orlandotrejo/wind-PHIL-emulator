% Generacion de una señal de viento longitudinal
% Incluye la componente promedio y la turbulencia longitudinal (von Karman)
% ENTRADAS: Altura (h), parámetros distribución Weibull (beta, lambda)
% ENTRADAS: tiempo de muestreo en segundos (ts)
% ENTRADAS: tiempo de duración de la señal generada (len)
% SALIDAS: Gráfico con la señal de viento en tiempo

h = 60;         % Altura en metros
lambda_weib = 10.96; % Factor de escala (a)
beta_weib = 4.29; % Factor de forma (b)
ts = 0.25;      % Paso de tiempo simulación
len = 60;       % Longitud de la simulación en segundos

Iref = 0.05;    % Intensidad de turbulencia

Iraf = 1;     % Intensidad de ráfaga
ti_raf = 10;    % Tiempo de inicio de la ráfaga
to_raf = 20;    % Tiempo de fin de la ráfaga

M_rampa = 1;   % Intensidad de la rampa
ti_rampa = 30;  % Tiempo de inicio de la rampa
to_rampa = 50;  % Tiempo de final de la rampa

delta_n = 1e-5; % Tiempo de muestreo para la suma de las comp. espectro

% ----------------------------
% Hasta aquí las entradas...

% Componente promedio

pd_weib = makedist('Weibull','a',lambda_weib,'b',beta_weib);
U = random(pd_weib);

% Componente de turbulencia

I = Iref*(0.75+5.6/U); % Intensidad de la turbulencia

n = 0.0001:delta_n:1; % Recorre el espectro frecuencial
t = ts:ts:len; % Recorre la señal en tiempo

Lu2 = 0.3048*h/((0.0539+0.25e-3*h)^1.2); % Escala de longitud

Ut = zeros(1,length(t));
Utp = 0;
Ur = 0;
Up = 0;

for m=1:length(t)
    
    phi = 2*pi*random('Uniform',-pi, pi); % Factor delta phi del modelo
    amp = random('Uniform',0.25, 1.75); % Compensa la amp inicial
    
for i=1:length(n)
    
    SuV = 4*n(i)*Lu2/U/((1+70.8*(n(i)*Lu2/U)^2)^(5/6));
    
    Utp = Utp + amp*sqrt(SuV*delta_n)*I*cos(2*pi*n(i)+phi); % Turbulencia

end

    if (m*ts > ti_raf && m*ts < to_raf ) % Componente de ráfaga
        Ur = Iraf*sin(2*pi*8*(m-ti_raf/ts)/len/(to_raf-ti_raf)); 
    else
        Ur = 0;
    end
    
    if (m*ts > ti_rampa && m*ts < to_rampa) % Rampa
        Up = M_rampa*(m-ti_rampa/ts)/len;
    elseif (m*ts > 50)
        Up = M_rampa*(to_rampa-ti_rampa)/ts/len;
    end
    
    Ut(m) = U + Up + Utp + Ur;
    Utp = 0;

end

plot(t,Ut)
