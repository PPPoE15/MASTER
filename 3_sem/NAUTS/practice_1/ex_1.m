clc, clear, close all
tspan = [0 20];

initial_conditions = [0.8, 0.02; 0.01, -0.7; 0.05, -0.05];

[t1, y1] = ode45(@system, tspan, initial_conditions(1,:)); 
[t2, y2] = ode45(@system, tspan, initial_conditions(2,:)); 
[t3, y3] = ode45(@system, tspan, initial_conditions(3,:)); 

figure;

subplot(2,1,1);
plot(t1, y1(:,1), 'DisplayName', 'x, нач. усл. = [0.8, 0.02]');  % x(t)
hold on;
xlabel('Время, t');
ylabel('x(t)');
title('Переходные процессы для x(t)');

subplot(2,1,2);
plot(t1, y1(:,2), 'DisplayName', 'y, нач. усл. = [0.8, 0.02]');  % y(t)
hold on;
xlabel('Время, t');
ylabel('y(t)');
title('Переходные процессы для y(t)');

subplot(2,1,1);
plot(t2, y2(:,1), 'DisplayName', 'x, нач. усл. = [0.01, -0.7]');  % x(t)
hold on;

subplot(2,1,2);
plot(t2, y2(:,2), 'DisplayName', 'y, нач. усл. = [0.01, -0.7]');  % y(t)
hold on;

subplot(2,1,1);
plot(t3, y3(:,1), 'DisplayName', 'x, нач. усл. = [0.05, -0.05]');  % x(t)
legend show;
hold on;

subplot(2,1,2);
plot(t3, y3(:,2), 'DisplayName', 'y, нач. усл. = [0.05, -0.05]');  % y(t)
legend show;
hold off;

% Построение фазовых траекторий для всех наборов начальных условий
figure;

plot(y1(:,1), y1(:,2), 'DisplayName', 'Фазовая траектория, нач. усл. = [0.8, 0.02]');
hold on;
plot(y2(:,1), y2(:,2), 'DisplayName', 'Фазовая траектория, нач. усл. = [0.01, -0.7]');
hold on;
plot(y3(:,1), y3(:,2), 'DisplayName', 'Фазовая траектория, нач. усл. = [0.05, -0.05]');
xlabel('x');
ylabel('y');
title('Фазовые траектории');
legend show;
hold off;

function dydt = system(t, y)
    dydt = zeros(2,1);
    dydt(1) = -y(1) + 2*y(2)^2 + y(1)*y(2);
    dydt(2) = -y(2)^3 + y(1)^2;
end
