% Se plantea la solución al punto 3
% 3. Obtener las pérdidas eléctricas, las cargas y generadores que más 
% impactan al sistema. Realice un pequeño algoritmo para realizar esta tarea.

clear all
clc
% name = 'case118_proyecto';
name = 'case118';

% Cargamos el caso
mpc = loadcase(name);
opt = mpoption('VERBOSE',0, 'OUT_ALL',0);
% Ejecutamos el flujo de potencia
res = runpf(mpc, opt);

%% Calculo de perdidas
losses = res.branch;
losses(:, 18) = real(get_losses(res));
losses = sortrows(losses, 18, "descend");

%% Obtención de cargas mas importantes. Se considera como la carga mas 
% importante la de mayor valor
cargas = sortrows(res.bus,3, "descend");

%% Obtención del generador mas importante. Se considera como el generador
% mas importante al generador con mayor generación
generador = sortrows(res.gen, 2, "descend");

%% Resultados obtenidos
fprintf('El elemento con mayor perdida se encuentra entre las barras %d - %d con %.4f MW\n', losses(1,1), losses(1,2),  losses(1,18));
fprintf('La carga más importante está en la barra %d con %d MW\n', cargas(1,1), cargas(1,3));
fprintf('El generador mas importante se encuentra conectado en la barra %d con %d MW\n', generador(1,1), generador(1,2));




