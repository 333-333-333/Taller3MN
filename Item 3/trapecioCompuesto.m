%% Parámetros de entrada:
% > 'f' es la función a integrar.
% > 'a' y 'b' son los límites inferior y superior, respectivamente, del
% intervalo de integración.
% > 'n' es el número de particiones que se le harán al intervalo.

%% Parámetro de salida:
% > 'I' Es la aproximación por el método de trapecio compuesto de la
% integral desde 'a' hasta 'b' de 'f(x)' en diferencial de 'x'.

function I = trapecioCompuesto(f, a, b, n)

% > 'h' es la equidistancia entre los números en el intervalo. Es
% inversamente proporcional a 'n'.

h = (b - a) / n;

% La colección de puntos para aproximar el valor de la integral estará
% dado por el linspace 'a : h : b'.

x = a : h : b;

% Inicialmente, al valor de la integral se les suma el valor de 'f(a)' y
% 'f(b)'.

I = f(x(1)) + f(x(n + 1));

% Se podría haber usado el comando 'sum' para poder ejecutar, no obstante,
% la sumatoria es capaz de gestionar algunas excepciones que con el comando
% anterior se requeriría de validar de algúna otra forma (EJ: n = 1).

for i = 2 : n
    I = I + 2 * f(x(i));
end

% Finalmente, para obtener el resultado final, se multiplica 'I' por 'h/2'.

I = I * (h / 2);

end
