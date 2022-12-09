%% Parámetros iniciales:

    %% No se limpian ejecuciones previas, es importante ejecutar el script 1 de
    % forma previa.

    %% Limpia ejecuciones previas.
    clc;
        
    %% Formato long, para poder apreciar mejor la presición de los
    % decimales obtenidos.

    format long;

    %% Hold on, para poder apreciar varias gráficas a la vez.

    hold on;

%% Datos globales:

    %% Sea importa el archivo 'A_data_preg1.mat',y se asignan sus a la 
    % variable 'A'.

    load('A_datos_t.mat');
    A = A_data_t;

%% Caso 1: En base a la función más precisa obtenida en el ítem 1.

    %% IMPORTANTE : Ejecutar el script 1 previo a este.
    % En base a lo visto en el punto 1, finalmente se utilizará el ajuste
    % no lineal para este item.
    f = @(x) K1(1) + K1(2) ./x + K1(3) ./ x .^ 2;

    % Hay que establecer los dos valores de 'a' y 'b' para ambos casos de
    % esta función. Posteriormente, se establecerán diversos valores de
    % 'm', para poder comparar la presición.

    % Para la primera rutina
    a1 = 1;
    b1 = 6;

    % Para la segunda rutina
    a2 = 1;
    b2 = 20;

    % Valores de 'm' para temas de demostración
    m1 = 10;
    m2 = 100;
    m3 = 1000;

    % Se calculan los linspace para los primeros valores de 'a' y 'b'.
    x11 = linspace(a1, b1, m1);
    x12 = linspace(a1, b1, m2);
    x13 = linspace(a1, b1, m3);

    % Dados los linspace, se calculan sus respectivos vectores de 'y' en
    % base a la función asignada previamente.
    y11 = f(x11);
    y12 = f(x12);
    y13 = f(x13);

    %% Finalmente, se calculan las distancias.
    D11 = distanciaRecorrida(x11, y11)
    D12 = distanciaRecorrida(x12, y12)
    D13 = distanciaRecorrida(x13, y13)

    % Se calculan los linspace para los segundos valores de 'a' y 'b'.
    x21 = linspace(a2, b2, m1);
    x22 = linspace(a2, b2, m2);
    x23 = linspace(a2, b2, m3);

    % Dados los linspace, se calculan sus respectivos vectores de 'y' en
    % base a la función asignada previamente.
    y21 = f(x21);
    y22 = f(x22);
    y23 = f(x23);

    %% Finalmente, se calculan las distancias.
    D21 = distanciaRecorrida(x21, y21)
    D22 = distanciaRecorrida(x22, y22)
    D23 = distanciaRecorrida(x23, y23)

%% Caso 2: En base a los puntos dados por el arcivo importado.
    % Se establecen los puntos 'xb' e 'yb' en base al archivo.
    xb = A(:, 1);
    yb = A(:, 2);
    
    %  Se calcula la distancia.
    DB = distanciaRecorrida(xb, yb)