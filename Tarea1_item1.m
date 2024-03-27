
% Se plantea la solución al punto 1
% 1. Cómo operaría el sistema sólo con el generador Slack.

clear all
clc


mpc = loadcase('case118');

% Hacemos la extración de los generadores en una variable
gen = mpc.gen;
bus = mpc.bus;

% Sabemos que el generador slack esta en una barra tipo 3. Procedemos a
% buscar la barra slack, identificamos el generadory pasamos su estado a cero. Una vez
% hayamos conseguido esto, ejecutamos el flujo unicamente con el slack en
% el sistema

% Buscamos la barra slack
barraSlack = 0;
for i = 1:length(bus)
    if bus(i, 2) == 3
        barraSlack = bus(i, 1);
    end
end

% apagamos los generadores diferentes al slack

for i = 1:length(gen)
    if gen(i, 1) ~= barraSlack
        gen(i, 8) = 0;
    end
end

mpc.gen = gen;

resultado = runpf(mpc)

% Como resultado de esta simulación tenemos que el flujo no converge
% despues de realizar 10 iteraciones

