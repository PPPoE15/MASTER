%% изображаем ОДР
close all
clc, clear
syms x y
f1 = (3 - x) / 3;
f2 = (35 - 7*x) / 5;
f3 = (8 - 2*x) / 4;
f4 = (24 + 4*x) / 6;

figure(1)
hold on
fplot(f1, 'r')
fplot(f2, 'r')
fplot(f3, 'r')
fplot(f4, 'r')
grid on
xlim([-2 6])
ylim([-2 6])
xlabel('x_1')
ylabel('x_2')

plot([0 0],[0 10], 'b')
plot([10 0],[0 0], 'b')

%% изображаем целевую функцию и ее градиент
Z0 = -0.5*x;
fplot(Z0, color = 'g', LineStyle='--')
quiver(0, 0, 2, 4, Color='k')

%% смещаем линию уровню по направлению градиента целевой функции
Z = -0.5*x + 1.5;
fplot(Z, color = 'g', LineStyle='-')
plot(3,0, '*', color='k')
hold off
