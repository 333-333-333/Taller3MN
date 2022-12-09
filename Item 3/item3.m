%% Parámetros de entrada:
% > 'f' es la función a integrar.
% > 'a' y 'b' son los límites inferior y superior, respectivamente, del
% intervalo de integración.
% > 'tol' es la tolerancia máxima que debe tener la aproximación respecto
% al valor real de la integral

%% Parámetro de salida:
% > 'N2' es un vector que contiene la cantidad de intervalos necesarios
% para que el error de la aproximación para cada método sea menor o igual a
% la tolerancia ingresada en la rutina. El primer valor está asociado al
% método del trapecio, y el segundo, al de Simpson.
% > 'C2' es un vector de aproximaciones de 'c' que cumplen el teorema del
% valor medio para integrales, donde el primer valor está asociado al
% método del trapecio, y su segundo, al de Simpson.

%% Función con aceleración.

function [N2, C2] = item3(f, a, b, tol)

%% Inicialización de parámmetros

format long;

% Para poder comparar el error absoluto de cada aproximación, se tomará
% como valor real de la integral al dado por el método 'integral' propio de
% MatLab.

I_Real = integral(f, a, b);

% Se inicializan los errores para poder ejecutar el ciclo iterativo
% 'while'.
err1 = tol + 1;
err2 = tol + 1;

% Se inicializan los números de particiones en cero.
n1 = 0;
n2 = 0;

% De igual forma, para posteriormente calcular los valores aproximados de
% 'c' que satisfazcan el teorema de valor medio, se inicializan las
% aproximaciones de la integral.
I_aprox_1 = 0;
I_aprox_2 = 0;

% En caso de que la rutina parezca quedarse estancada, se implementará un
% sistema para ir incrementando exponencialmente el aumento de particiones.
% El incremento varía entre los métodos, ya que simpson suele ser más
% preciso que Trapecio.
i1 = 1;
i2 = 2;

% Mediante un ciclo 'while', se calcula recursivamente la aproximación
% mediante el método del trapecio de la integral, hasta que el error
% absoluto de la original menos la aproximación sea menor a la tolerancia.
while err1 >= tol
    n1 = n1 + i1;
    I_aprox_1 = trapecioCompuesto(f, a, b, n1);
    err1 = abs(I_Real - I_aprox_1);
end

% Mediante un ciclo 'while', se calcula recursivamente la aproximación
% mediante el método de Simpson de la integral, hasta que el error
% absoluto de la original menos la aproximación sea menor a la tolerancia.
while err2 >= tol
    n2 = n2 + i2;
    I_aprox_2 = simpsonCompuesto(f, a, b, n2);
    err2 = abs(I_Real - I_aprox_2);
end

% Obtenidos 'n1' y 'n2', se agregan al retorno en forma de vector.
N2 = [n1, n2];

%% Para poder aproximar 'c', se requiere saber que:
% > f(c) = (F(b) - F(a)) / (b - a)
% > Sea g(x) = f(x) - f(c), entonces su (o sus) posible raiz será 'c'.

% Se calcula f(c_1), para la aproximación dada por el método del trapecio.
fc1 = 1 / (b - a) * I_aprox_1;
% Se declara su respectiva g(x).
f_1 = @(x) f(x) - fc1;
% Mediante 'fzero', se busca la raíz en el intervalo ingresado por el
% usuario.
c1 = fzero(f_1, [a, b]);

% Se calcula f(c_1), para la aproximación dada por el método de Simpson.
fc2 = 1 / (b - a) * I_aprox_2;
% Se declara su respectiva g(x).
f_2 = @(x) f(x) - fc2;
% Mediante 'fzero', se busca la raíz en el intervalo ingresado por el
% usuario.
c2 = fzero(f_2, [a, b]);

% Obtenidas 'c1' y 'c2', se agregan al retorno en forma de vector.
C2 = [c1, c2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Para poder utilizar las funciones de forma recursiva, se definen de 
% forma interna en la rutina.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

I = I * h / 2;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end