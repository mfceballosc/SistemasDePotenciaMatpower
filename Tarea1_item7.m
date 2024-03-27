

% 6. Cuáles elementos no deben desconectarse de la red eléctrica. 
% Realice un pequeño algoritmo para realizar esta tarea

clear all
clc
% Se asume que las lineas que representan mayor riesgo para el sistema son
% las que se estan sobrecargando o estan más proximas o la que genere mayor
% caida de tensión

% name = 'case39';
% Caso modificado, incluida la linea y los dos generadores de microred
name = 'case118_microRed';

% Cargamos el caso
mpc = loadcase(name);
opt = mpoption('VERBOSE',0, 'OUT_ALL',0);

% Vector donde se guardará el resultado de los elementos
n_1 = string({});
con = 1;
% Ejecutamos n-1 para identificar elementos que no deben salir del sistema
for i = 1:length(mpc.branch)
    % Crea un nuevo caso
    mpc2 = mpc;
    mpc2.branch(i, 11) = 0;
    % Ejecutamos el flujo de potencia
    res = runpf(mpc2, opt);
    if res.success
    else
        n_1 = [n_1, string({strcat(string(mpc2.branch(i,1))," - " ,string(mpc2.branch(i,2)))})];
        con = con + 1;
    end
end



for i = 1:length(n_1)
    fprintf('%d. Elemento que no se debe desconectar entre las barras %s \n', i, n_1(i));
end

% Desconexión de los generadores
n_g = [];
con = 1;
% Ejecutamos n-1 para identificar elementos que no deben salir del sistema
for i = 1:length(mpc.gen)
    % Crea un nuevo caso
    mpc2 = mpc;
    mpc2.gen(i, 8) = 0;
    % Ejecutamos el flujo de potencia
    res = runpf(mpc2, opt);
    if res.success
    else
        n_g(con) = mpc2.gen(i,1)
        con = con + 1;
    end
end
for i = 1:length(n_g)
    fprintf('%d. Generador que no se debe desconectar esta en la barra %d \n', i, n_g(i));
end

