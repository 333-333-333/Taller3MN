%% Parámetros iniciales:

    %% Limpia ejecuciones previas.
    clc;
    clear;

    %% Formato long, para poder apreciar mejor la presición de los
    % decimales obtenidos.

    format long;

    %% Hold on, para poder apreciar varias gráficas a la vez.

    hold on;

    %% Grid on, para mostrar la malla.

    grid on;

%% Datos globales:

    %% Sea importa el archivo 'A_data_preg1.mat',y se asignan sus a la 
    % variable 'A'.

    load('A_data_preg1.mat');
    A = A_data_preg1;

    %% Los métodos lsqcurvefit y polyfit requieren como parámetros una 
    % función un vector con valores iniciales, un vector 'x', y un vector
    % 'y'. Desde  A, se extraen 'xd' e 'yd'.

    xd = A(:, 1);
    yd = A(:, 2);

%% Ajuste no lineal (lsqcurvefit).

    %% Sean el vector K1 los tres valores correspondientes al ajuste no-lineal
    % a realizar:

    %% Se declara la función del respectivo ajuste de curva (f).

    f = @(K, x) K(1) + K(2) ./ x + K(3) ./ x .^ 2;

    %% Se calcula el ajuste de la función no lineal.

    K1 = lsqcurvefit(f, [0, 0, 0], xd, yd);

    %% Posteriormente, se declara un vector 'y1', donde estarán los datos
    % procesados por 'f' de 'xd'.

    y1 = f(K1, xd);

    %% Finalmente, se grafica.

    plot(xd, y1, 'r');

%% Ajuste lineal (polyfit).

    %% Dado que el método de 'polyfit' no requiere de una función de 
    % entrada, solo basta con analizar de que el polinomio exigido para la
    % interpolación es de grado 3. Dado esto, se ejecuta el comando, donde
    % el retorno 'K2' seran los coeficientes de cada término del polinomio.

    K2 = polyfit(xd, yd, 3);

    %% Teniendo K2, se evalúan las X en el polinomio mediante 'polyval' en 
    % el arreglo 'y2'.

    y2 = polyval(K2, xd);

    %% Finalmente, se grafica.

    plot(xd, y2, 'b');

%% Teniendo las dos funciones graficadas, se muestran las imágenes de los
% puntos coordenados originales, esto con el propósito de comparar.

plot(xd, yd, '*');

%% La exposición de la presición de los datos se debe hacer, más que en            
% forma analítica con los gráficos, de forma matemática, mediante los
% errores que hay entre los puntos originales y los otorgados por las
% funciones. Para lo cual, se calcularán los errores absolutos por puntos
% de cada arreglo, donde 'err1' corresponde al del ajuste no lineal, y
% 'err2' al del ajuste lineal.

err1 = abs(yd - y1);
err2 = abs(yd - y2);

%% Se generan tres tablas, una para cada error, y una para la función 
% original,cuyas primeras columnas están reservadas al valor de 'xd', las 
% segundas, al respectivo valor de y otorgado, y la tercera, para los casos
% de las tablas de los ajustes, con el error absoluto entre el valor real
% ('yd') y el valor obtenido.

tabla1 = table(xd, y1, err1, 'variableNames', {'x', 'y', 'err1'})
tabla2 = table(xd, y2, err2, 'variableNames', {'x', 'y', 'err2'})
tabla3 = table(xd, yd, 'variableNames', {'x', 'y'})

%% Finalmente, se imprimen los máximos y minimos errores absolutos para 
% cada ajuste.

errMax1 = max(err1)
errMin1 = min(err1)
errMax2 = max(err2)
errMin2 = min(err2)