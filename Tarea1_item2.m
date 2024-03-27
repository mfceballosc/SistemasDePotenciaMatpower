
% Se plantea la solución al punto 2
% 2. Cuál es la máxima transferencia de potencia del sistema que se puede 
% obtener en la red. Realice un pequeño algoritmo para realizar esta tarea.

% A la respuesta de este punto se puede llegar aunmentando la carga hasta 
% llegar al limite de transferencia de las lineas o el limite de
% estabilidad del sistema.


% Procedemos a aumentar la carga del sistema

clear all
clc

% Cargamos el caso
mpc = loadcase('case118');

% Identificamos las cargas dentro del sistema. Estas se encuentran en la
% matriz Bus de mpc

P = 3;
Q = 4;
Pd = mpc.bus(:,P);
Qd = mpc.bus(:,Q);

% Carga inicial
disp("========================================");
fprintf("Demanda final:\n%s  MW\n%s MVAR\n",  num2str(sum(Pd)),num2str(sum(Qd)));
disp("========================================");

% evitamos que se imprima datos en la consola
opt = mpoption('VERBOSE',0, 'OUT_ALL',0);

% Calculo de la potencia inicial
Pini = sum(Pd);
Qini = sum(Qd);

% Variacion de la potencia
Pvar = [];
Qvar = [];
steps = [];
idx = 1;
for factor = 1 : 0.01 : 2
    % modifica la carga
    mpc.bus(:,P) = factor*Pd;
    mpc.bus(:,Q) = factor*Qd;
    % Ejecuta el flujo
    res = runpf(mpc, opt);
    if res.success
        disp('***************************************************************')
        disp("Flujo de potencia exitoso. Factor = " + num2str(factor))
        disp('***************************************************************') 
        % Almacena cada una de las variaciones de potencia donde el caso
        % converge
        Pvar(idx) = sum(factor*Pd);
        Qvar(idx) = sum(factor*Qd);
        steps(idx) = factor;
        idx = idx + 1;
    end
end

% =========================================================================
% =========================================================================
% El sistema converge hasta hasta que su carga a aumentado un 80 de la
% original
% =========================================================================
% =========================================================================

% Carga inicial
disp("========================================");
fprintf("Demanda final:\n%s  MW\n%s MVAR\n", num2str(sum(Pvar(idx-1))) , num2str(sum(Qvar(idx-1))));
disp("========================================");


plot(steps, Pvar, 'g--')
hold on
plot(steps, Qvar, 'b--')
title('Incremento de potencias')
xlabel('Factor de incremento')
ylabel('MW/MVAR')
hold off
legend('P [MW]', 'Q [MVAR]')
grid on


