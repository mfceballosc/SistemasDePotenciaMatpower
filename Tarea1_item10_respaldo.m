name = 'case118';
% Cargamos el caso
mpc = loadcase(name);

% Ejecuta el flujo de potencia y guarda resultados en output_pf.txt
diary('output_pf.txt');
res = runpf(mpc);
diary off;

% Ejecuta el flujo de potencia optimo y guarda resultados en output_opf.txt
mpc = loadcase(name);
diary('output_opf.txt');
resOpt = runopf(mpc);
diary off;

% info generación
genPF = res.gen(:, [1, 2, 9]);       % generación del flujo de potencia
genOPF = resOpt.gen(:, [1, 2, 9]);   % generación del flujo optimo de potencia
% Une los resultados de generación para comparar
comparaGeneracion = [genPF genOPF];
% Costo total de generación
resOpt.f;
