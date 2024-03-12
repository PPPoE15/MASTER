clc, clear, close all
x_0 = 2;
y_0 = 0;
z_0 = 0;
T = 20;

sys = @(t,x) [  x(2); 
                0.5*x(3); 
                -2*x(1) - 4*x(2) - 3*x(3)];

[t, sol] = ode45(sys, [0 T], [x_0 y_0 z_0]);


figure(1)
plot3(sol(:,1),sol(:,2),sol(:,3))
grid on
figure(2)
title('Численное решение');
hold on
plot(t,sol(:,1), '.',t,sol(:,2), '.',t,sol(:,3), '.')
grid on



syms x1(t) x2(t) x3(t) a
eqn(1) = diff(x1,t) == x2;
eqn(2) = diff(x2,t) == 0.5*x3;
eqn(3) = diff(x3,t) == -2*x1 - 4*x2 - 3*x3;
cond(1) = x1(0) == 2;
cond(2) = x2(0) == 0;
cond(3) = x3(0) == 0;
S = dsolve(eqn, cond)

syms t z; % Объявляем временную переменную t как символьную
% Определяем корни полинома
z1 = root(z^3 + 3*z^2 + 2*z + 1, z, 1);
z2 = root(z^3 + 3*z^2 + 2*z + 1, z, 2);
z3 = root(z^3 + 3*z^2 + 2*z + 1, z, 3);

% Определяем функцию
f1 = S.x1;
f2 = S.x2;
f3 = S.x3;


% Построение графика
figure(3)
hold on
fplot(f1, [0, 20]); 
fplot(f2, [0, 20]);
fplot(f3, [0, 20]);
xlabel('t');
ylabel('f(t)');
title('Аналитическое решение');