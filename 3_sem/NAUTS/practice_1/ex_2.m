tspan = [0 20];

initial_conditions = [0.8, 0.2; -0.7, -0.7; 0.5, -0.5];

[t1, y1] = ode45(@system, tspan, initial_conditions(1,:)); 
[t2, y2] = ode45(@system, tspan, initial_conditions(2,:));
[t3, y3] = ode45(@system, tspan, initial_conditions(3,:));

figure;

subplot(2,1,1);
plot(t1, y1(:,1), 'DisplayName', 'x1, нач. усл. = [0.8, 0.2]');
hold on;
xlabel('Время, t');
ylabel('x_1(t)');
title('Переходные процессы для x_1(t)');
legend;
grid on;

subplot(2,1,2);
plot(t1, y1(:,2), 'DisplayName', 'x2, нач. усл. = [0.8, 0.2]');
hold on;
xlabel('Время, t');
ylabel('x_2(t)');
title('Переходные процессы для x_2(t)');
legend;
grid on;

subplot(2,1,1);
plot(t2, y2(:,1), 'DisplayName', 'x1, нач. усл. = [0.01, -0.7]');
hold on;

subplot(2,1,2);
plot(t2, y2(:,2), 'DisplayName', 'x2, нач. усл. = [-0.7, -0.7]');
hold on;

subplot(2,1,1);
plot(t3, y3(:,1), 'DisplayName', 'x1, нач. усл. = [0.5, -0.5]');
legend show;
hold on;

subplot(2,1,2);
plot(t3, y3(:,2), 'DisplayName', 'x2, нач. усл. = [0.5, -0.5]');
legend show;
hold off;

figure; 

plot(y1(:,1), y1(:,2), 'DisplayName', 'Фазовая траектория, нач. усл. = [0.8, 0.2]');
hold on;

plot(y2(:,1), y2(:,2), 'DisplayName', 'Фазовая траектория, нач. усл. = [-0.7, -0.7]');
hold on;

plot(y3(:,1), y3(:,2), 'DisplayName', 'Фазовая траектория, нач. усл. = [0.5, -0.5]');
xlabel('x_1');
ylabel('x_2');
title('Фазовые траектории');
legend show;
grid on;
hold off;

function dydt = system(t, y)
    dydt = zeros(2,1);
    dydt(1) = (-3*y(1)*(1 - exp(-t)) + y(2)*(1 - exp(-t)) - y(1)) / 2;  % dx1/dt
    dydt(2) = (y(1)*(1 - exp(-t)) - 3*y(2)*(1 - exp(-t)) - y(2)) / 2;   % dx2/dt
end
