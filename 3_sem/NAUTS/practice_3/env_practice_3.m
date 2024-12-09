%% task 2
clc, clear, close all

x20 = 10;
x10 = 0;
sim("task_2.slx")

%% surface
close all
figure
[x1,x2] = meshgrid(-20:0.1:20,-20:20);
V = 0.5.*x2.^2 + 3.*x1.^2 + x1.^3;
plot(x1,V)
xlabel("x1")
ylabel("V")
grid

figure
[x1,x2] = meshgrid(-20:20,-20:20);
V = 0.5.*x2.^2 + 3.*x1.^2 + x1.^3;
surface(x1,x2,V)
xlabel("x1")
ylabel("x2")
zlabel("V")
zlim([0 500])
grid

figure
[x1,x2] = meshgrid(-20:20,-20:20);
dV = -x2.^2;
surface(x1,x2,dV)
xlabel("x1")
ylabel("x2")
zlabel("V`")


%% task 1
clc, clear, close all

k1 = 2;
k3 = 3;

g = @(t) 1; % Единичное ступенчатое воздействие

% % Определение системы уравнений без управления
f = @(t, x) [
    % x1
    2 * sin(3 * x(1)) + 4 * x(2);
    
    % x2
    x(2)^2 + 3 * x(2) * x(1) + x(3) - x(1)^3;
    
    % x3
    g(t)
];

% Определение системы уравнений
% f = @(t, x) [
%     % x1
%     2 * sin(3 * x(1)) + 4 * x(2);
    
%     % x2
%     x(2)^2 + 3 * x(2) * x(1) + x(3) - x(1)^3;
    
%     % x3
%     -k3 * (x(3) - (-x(2) - k1 * x(1) - 3 * x(2) * x(1) - x(2)^2 + x(1)^3 - ...
%     2 * k1 * sin(3 * x(1)) - 4 * k1 * x(2))) ...
%     - g(t) + ...
%     (-2 * x(2) * (x(2)^2 + 3 * x(2) * x(1) + x(3) - x(1)^3) - ...
%     3 * (x(2)^2 * x(1) + x(2) * x(1)^2 * (2 * sin(3 * x(1)) + 4 * x(2))) + ...
%     3 * x(1)^2 * (2 * sin(3 * x(1)) + 4 * x(2)) - ...
%     k1 * (6 * cos(3 * x(1)) * (2 * sin(3 * x(1)) + 4 * x(2)) + ...
%     4 * (x(2)^2 + 3 * x(2) * x(1) + x(3) - x(1)^3)))
% ];

% Время моделирования
tspan = [0 10]; 

% Начальные условия для моделирования разных переходных процессов
initial_conditions = [
    0, 0, 0; 
    1, 0, 0; 
    -1, 0, 0;
    0, 1, 0; 
    0, -1, 0 
];

% Решение системы для разных начальных условий и построение графиков

figure(1)
for i = 1:size(initial_conditions, 1)
    
    % Получаем начальные условия
    x0 = initial_conditions(i, :);
    
    % Решаем систему
    [t, x] = ode45(f, tspan, x0);
    
    % Переходный процесс для x1
    subplot(3, 1, 1);
    plot(t, x(:, 1), 'DisplayName', sprintf('x1, Н.У.: [%.1f, %.1f, %.1f]', x0(1), x0(2), x0(3)));
    hold on;
    
    % Переходный процесс для x2
    subplot(3, 1, 2);
    plot(t, x(:, 2), 'DisplayName', sprintf('x2, Н.У.: [%.1f, %.1f, %.1f]', x0(1), x0(2), x0(3)));
    hold on;
    % Переходный процесс для x3
    subplot(3, 1, 3);
    plot(t, x(:, 3), 'DisplayName', sprintf('x3, Н.У.: [%.1f, %.1f, %.1f]', x0(1), x0(2), x0(3)));
    hold on;
end

% Настройки для графиков
subplot(3, 1, 1);
title('Переходные процессы x1');
xlabel('Время t');
ylabel('x1');
legend show;
grid on;

subplot(3, 1, 2);
title('Переходные процессы x2');
xlabel('Время t');
ylabel('x2');
legend show;
grid on;

subplot(3, 1, 3);
title('Переходные процессы x1');
xlabel('Время t');
ylabel('x3');
legend show;
grid on;


figure(2)
for i = 1:size(initial_conditions, 1)
    x0 = initial_conditions(i, :);    
    [t, x] = ode45(f, tspan, x0);
    plot3(x(:, 1), x(:, 2), x(:, 3));
    hold on;
    grid on;
    xlabel('x1');
    ylabel('x2');
    zlabel('x3');
end
title('Фазовый портрет');
xlabel('x1');
ylabel('x2');
zlabel('x3');
grid on;
