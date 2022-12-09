%% Parámetros de entrada:
% > 'x' e 'y' son vectores de puntos ordenados.*

%% Observaciones:
% * Deben ser de la misma dimensión.

%% Parámetro de salida.
% > 'D' Es la suma de las distancias entre puntos, calculadas con teorema
% de pitágoras.

function D = distanciaRecorrida(x, y)

% Se inicializa el valor del retorno en 0.
D = 0;
% Para iterar, se establece un n como la longitud de uno de los vectores.
% (Acá se supone que son de la misma dimensión)
n = length(x);

for i = 1 : n - 1
    % Calcula y suma las distancias puntuales entre un punto y su sucesor
    % al retorno.
    c1cuadrado = (x(i + 1) - x(i)) ^ 2;
    c2cuadrado = (y(i + 1) - y(i)) ^ 2;
    D = D + sqrt(c1cuadrado + c2cuadrado);
end

end