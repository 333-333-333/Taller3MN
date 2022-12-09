%% Parámetros de entrada:
% > 'f' es la función a integrar.
% > 'a' y 'b' son los límites inferior y superior, respectivamente, del
% intervalo de integración.
% > 'n' es el número de particiones que se le harán al intervalo. *

%% Observaciones:
% * 'n' OBLIGATORIAMENTE debe ser par.

%% Parámetro de salida:
% > 'I' Es la aproximación por el método de Simpson compuesto de la
% integral desde 'a' hasta 'b' de 'f(x)' en diferencial de 'x'.

function I = simpsonCompuesto(f, a, b, n)

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

% Simpson tiene dos sumatorias, por temas de limpiezas de código, esta se
% calcularán por separados, y finalmente, se sumarán al valor de 'I'.

sum1 = 0;
sum2 = 0;

% Como se debe excluir el primer y el último punto, y los índices de 
% los arreglos en matlab, a difrerencia de otros lenguajes de 
% programación, va desde el 1 hasta el propio largo del arreglo, se 
% reajustan los datos de la sumatoria, asociando la de índices impares 
% a los pares y viceversa.

for i = 2 : n
    if mod(i, 2) ~= 0
        sum1 = sum1 + f(x(i));
    else
        sum2 = sum2 + f(x(i));
    end
end

I = I + 2 * sum1 +  4 * sum2;

% Finalmente, para obtener el resultado final, se multiplica 'I' por 'h/3'.

I = I * (h / 3);

end
