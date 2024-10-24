% % Базовая модель векторного управления с компенсацией пульсаций момента
% % и адаптивным прогнозированием
% 
% % Параметры двигателя
% Ld = 0.01;  % Индуктивность по оси d, Гн
% Lq = 0.01;  % Индуктивность по оси q, Гн
% Rs = 0.5;   % Сопротивление статора, Ом
% J = 0.1;    % Момент инерции, кг*м^2
% p = 4;      % Число пар полюсов
% psi_f = 0.1;% Поток возбуждения, Вб
% 
% % Создание новой модели Simulink
% mdl = 'SynchMotorTorqueRippleControl_1';
% new_system(mdl);
% open_system(mdl);
% 
% % Добавление блока синхронного двигателя
% add_block('powerlib/Machines/Permanent Magnet Synchronous Machine', [mdl '/PMSM']);
% % set_param([mdl '/PMSM'], 'Rs', 'Rs', 'J', 'J', 'p', 'p', 'Flux linkage', 'psi_f');
% 
% % Добавление инвертора
% add_block('powerlib/Power Electronics/Universal Bridge', [mdl '/Inverter']);
% % set_param([mdl '/Inverter'], 'Power Electronic device', 'IGBT/Diodes');
% 
% % ПИ-регуляторы тока
% add_block('simulink/Continuous/PID Controller', [mdl '/PI_Id']);
% set_param([mdl '/PI_Id'], 'P', '10', 'I', '100');
% add_block('simulink/Continuous/PID Controller', [mdl '/PI_Iq']);
% set_param([mdl '/PI_Iq'], 'P', '10', 'I', '100');
% 
% % Преобразование dq-abc
% add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/dq2abc']);
% % set_param([mdl '/dq2abc'], 'MATLAB Function', ...
% %     'function [Ia, Ib, Ic] = fcn(Id, Iq, theta)\n    Idq = [Id; Iq];\n    T = 2/3 * [cos(theta) -sin(theta); cos(theta-2*pi/3) -sin(theta-2*pi/3); cos(theta+2*pi/3) -sin(theta+2*pi/3)];\n    Iabc = T * Idq;\n    Ia = Iabc(1);\n    Ib = Iabc(2);\n    Ic = Iabc(3);\nend');
% 
% % Преобразование abc-dq
% add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/abc2dq']);
% % set_param([mdl '/abc2dq'], 'MATLAB Function', ...
% %     'function [Id, Iq] = fcn(Ia, Ib, Ic, theta)\n    Iabc = [Ia; Ib; Ic];\n    T = 2/3 * [cos(theta) cos(theta-2*pi/3) cos(theta+2*pi/3); -sin(theta) -sin(theta-2*pi/3) -sin(theta+2*pi/3)];\n    Idq = T * Iabc;\n    Id = Idq(1);\n    Iq = Idq(2);\nend');
% 
% % Компенсатор пульсаций момента
% add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/TorqueRippleCompensator']);
% % set_param([mdl '/TorqueRippleCompensator'], 'MATLAB Function', ...
% %     'function Iq_comp = fcn(Iq, omega)\n    % Простая модель компенсации: синусоидальная коррекция\n    Iq_comp = Iq + 0.1 * sin(6 * omega * getCurrentTime());\nend');
% 
% % % Нейросетевой предиктор (упрощенная модель)
% % add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/NNPredictor']);
% % % set_param([mdl '/NNPredictor'], 'MATLAB Function', ...
% % %     'function [Id_pred, Iq_pred] = fcn(Id, Iq, omega)\n    % Упрощенная модель предсказания\n    Id_pred = Id;\n    Iq_pred = Iq + 0.05 * sin(6 * omega * (getCurrentTime() + 0.001));\nend');
% 
% % Калмановский фильтр (упрощенная модель)
% add_block('simulink/User-Defined Functions/MATLAB Function', [mdl '/KalmanFilter']);
% % set_param([mdl '/KalmanFilter'], 'MATLAB Function', ...
% %     'function [Id_est, Iq_est] = fcn(Id_meas, Iq_meas)\n    persistent x P\n    if isempty(x)\n        x = [0; 0];\n        P = eye(2);\n    end\n    % Параметры фильтра\n    Q = 0.1 * eye(2);  % Ковариация шума процесса\n    R = eye(2);        % Ковариация шума измерений\n    % Предсказание\n    x_pred = x;\n    P_pred = P + Q;\n    % Коррекция\n    y = [Id_meas; Iq_meas] - x_pred;\n    S = P_pred + R;\n    K = P_pred / S;\n    x = x_pred + K * y;\n    P = (eye(2) - K) * P_pred;\n    Id_est = x(1);\n    Iq_est = x(2);\nend');

% Соединение блоков
% add_line(mdl, 'PI_Id/1', 'dq2abc/1');
% add_line(mdl, 'PI_Iq/1', 'dq2abc/2');
% add_line(mdl, 'dq2abc/1', 'Inverter/g');
% add_line(mdl, 'Inverter/A', 'PMSM/A');
% add_line(mdl, 'Inverter/B', 'PMSM/B');
% add_line(mdl, 'Inverter/C', 'PMSM/C');
% add_line(mdl, 'PMSM/m', 'abc2dq/1');
% add_line(mdl, 'PMSM/m', 'abc2dq/2');
% add_line(mdl, 'PMSM/m', 'abc2dq/3');
% add_line(mdl, 'abc2dq/1', 'KalmanFilter/1');
% add_line(mdl, 'abc2dq/2', 'KalmanFilter/2');
% add_line(mdl, 'KalmanFilter/1', 'PI_Id/1');
% add_line(mdl, 'KalmanFilter/2', 'TorqueRippleCompensator/1');
% add_line(mdl, 'TorqueRippleCompensator/1', 'PI_Iq/1');
% add_line(mdl, 'PMSM/w', 'TorqueRippleCompensator/2');
% add_line(mdl, 'PMSM/w', 'NNPredictor/3');

% Добавление входов для задания токов
% add_block('simulink/Sources/Step', [mdl '/Id_ref']);
% % set_param([mdl '/Id_ref'], 'Time', '0', 'After', '0');
% add_block('simulink/Sources/Step', [mdl '/Iq_ref']);
% % set_param([mdl '/Iq_ref'], 'Time', '0', 'After', '10');
% 
% add_line(mdl, 'Id_ref/1', 'PI_Id/1');
% add_line(mdl, 'Iq_ref/1', 'PI_Iq/1');

% Добавление осциллографов для наблюдения за токами и моментом
% add_block('simulink/Sinks/Scope', [mdl '/Id_Scope']);
% add_block('simulink/Sinks/Scope', [mdl '/Iq_Scope']);
% add_block('simulink/Sinks/Scope', [mdl '/Torque_Scope']);

add_line(mdl, 'KalmanFilter/1', 'Id_Scope/1');
add_line(mdl, 'KalmanFilter/2', 'Iq_Scope/1');
add_line(mdl, 'PMSM/Te', 'Torque_Scope/1');

% Настройка параметров симуляции
% set_param(mdl, 'StopTime', '0.1');
% set_param(mdl, 'Solver', 'ode23tb');

% Сохранение модели
save_system(mdl);