% 5. Qué líneas traen el mayor riesgo de operación para el sistema. 
% Realice un pequeño algoritmo para realizar esta tarea.

clear all
clc
% Se asume que las lineas que representan mayor riesgo para el sistema son
% las que se estan sobrecargando o estan más proximas o la que genere mayor
% caida de tensión

% name = 'case39';
name = 'case118';

% Cargamos el caso
mpc = loadcase(name);
opt = mpoption('VERBOSE',0, 'OUT_ALL',0);

% loading
maxLoad = mpc.branch(:,6);

% Ejecutamos el flujo de potencia
res = runpf(mpc, opt);
% Calcula el flujo de potencia por cada linea
loading = (res.branch(:,14).^2 + res.branch(:,15).^2).^0.5;

% Agrupamos los datos
data = res.branch;
data(:,18) = loading;
data(:,19) = data(:,18)./data(:,6) *100;

data = sortrows(data, 18, "descend");

minVolts = sortrows(res.bus, 8);

%% Resultados obtenidos
id_fila = 1;
fprintf('El elemento con mayor cargabilidad esta entre las barras %d - %d con %.4f MW\n', data(id_fila,1), data(id_fila,2), data(id_fila,18));
id_fila = 2;
fprintf('El elemento con mayor cargabilidad esta entre las barras %d - %d con %.4f MW\n', data(id_fila,1), data(id_fila,2), data(id_fila,18));
id_fila = 3;
fprintf('El elemento con mayor cargabilidad esta entre las barras %d - %d con %.4f MW\n', data(id_fila,1), data(id_fila,2), data(id_fila,18));
id_fila = 4;
fprintf('El elemento con mayor cargabilidad esta entre las barras %d - %d con %.4f MW\n', data(id_fila,1), data(id_fila,2), data(id_fila,18));
id_fila = 5;
fprintf('El elemento con mayor cargabilidad esta entre las barras %d - %d con %.4f MW\n', data(id_fila,1), data(id_fila,2), data(id_fila,18));

id_fila = 1;
fprintf('La barra con mayor caida de tensión es la %d con %.4f pu\n', minVolts(id_fila,1), minVolts(id_fila, 8));
id_fila = 2;
fprintf('La barra con mayor caida de tensión es la %d con %.4f pu\n', minVolts(id_fila,1), minVolts(id_fila, 8));
id_fila = 3;
fprintf('La barra con mayor caida de tensión es la %d con %.4f pu\n', minVolts(id_fila,1), minVolts(id_fila, 8));
id_fila = 4;
fprintf('La barra con mayor caida de tensión es la %d con %.4f pu\n', minVolts(id_fila,1), minVolts(id_fila, 8));
id_fila = 5;
fprintf('La barra con mayor caida de tensión es la %d con %.4f pu\n', minVolts(id_fila,1), minVolts(id_fila, 8));




