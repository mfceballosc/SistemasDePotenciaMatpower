% 5. Qué líneas traen el mayor riesgo de operación para el sistema. 
% Realice un pequeño algoritmo para realizar esta tarea.

clear all
clc

name = 'case118';

% Cargamos el caso
mpc = loadcase(name);

% Ejecutamos el flujo de potencia 
diary('output_pf.txt');
res = runpf(mpc);
diary off;
% Ejecutamos el flujo de potencia optimo
mpc = loadcase(name);
% definimos la matriz de costos de generación

diary('output_opf.txt');
resOpt = runopf(mpc);
diary off;
%printpf(resOpt);


