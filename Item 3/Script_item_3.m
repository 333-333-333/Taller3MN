%% Parámetros iniciales:

    %% No se limpian ejecuciones previas, es importante ejecutar el script 1 de
    % forma previa.
    
    %% Limpia consola.
    clc;
        
    %% Formato long, para poder apreciar mejor la presición de los
    % decimales obtenidos.

    format long;

    %% Hold on, para poder apreciar varias gráficas a la vez.

    hold on;

    %% Grid on, para mostrar la malla.

    grid on;

%% Datos globales:

    %% IMPORTANTE : Ejecutar el script 1 previo a este.
    % En base a lo visto en el punto 1, finalmente se utilizará el ajuste
    % no lineal para este item.

    f = @(x) K1(1) + K1(2) ./x + K1(3) ./ x .^ 2;

    % Se definen los límites 'a' y 'b' que tendrán las rutinas a ejecutar.

    a = 1;
    b = 6;

    % Se definen las dos tolerancias distintas que utilizarán las rutinas.

    tol1 = 1e-3;
    tol2 = 1e-6;
    
%% Primera ejecución de rutina (La tolerancia es relativamente alta, asi
% que no requiere aceleración).
    
    [N1, C1] = item3(f, a, b, tol1)

%% Segunda ejecución de rutina (ADVERTENCIA : El volumen de computación es 
% alto, por lo cual, la entrega de resultados tardará, se requiere 
% aceleración).

    [N2, C2] = item3(f, a, b, tol2)

%% Finalmente, se imprimen los vectores N y C para posteriormente comparar.

N = [N1; N2]

C = [C1; C2]
