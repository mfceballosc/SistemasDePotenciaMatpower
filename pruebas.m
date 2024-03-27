% Definir el sistema
mpc = case39;

% Definir la carga variable
bus_load = 3;  % Barra donde se modifica la carga
P_load_min = 0.1;  % Valor mínimo de la carga (MW)
P_load_max = 1.0;  % Valor máximo de la carga (MW)
P_load_step = 0.05;  % Paso de variación de la carga (MW)

% Lista para almacenar resultados
P_max_list = [];
P_load_list = [];

% Bucle para variar la carga
i = 1
for P_load = P_load_min:P_load_step:P_load_max
    mpc.bus(bus_load, 3) = P_load;  % Modificar la carga en la barra
    
    % Solución del flujo de potencia
    res = runpf(mpc);
    
    % Calcular la potencia total en las barras
    P_bus = res.bus(:, 2);
    Q_bus = res.bus(:, 3);
    
    % Identificar la barra con la máxima potencia inyectada
    [P_inj_max, bus_inj_max] = max(P_bus);
    
    % Identificar la barra con la máxima potencia absorbida
    [P_abs_max, bus_abs_max] = min(P_bus);
    
    % Calcular la máxima transferencia de potencia
    P_max = abs(P_inj_max - P_abs_max);
    
    % Almacenar resultados
    P_max_list(i) = P_max;
    P_load_list(i) = P_load;
    i = i + 1;
end

% Encontrar la máxima transferencia de potencia
[P_max_opt, idx_max] = max(P_max_list);
P_load_opt = P_load_list(idx_max);

% Mostrar resultados
disp("Máxima transferencia de potencia: " + num2str(P_max_opt) + " MW");
disp("Carga óptima: " + num2str(P_load_opt) + " MW");

% Graficar la máxima transferencia de potencia vs la carga
plot(P_load_list, P_max_list);
xlabel("Carga (MW)");
ylabel("Máxima transferencia de potencia (MW)");




