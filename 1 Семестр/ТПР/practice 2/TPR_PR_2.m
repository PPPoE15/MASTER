%% изображаем ОДР
close all
clc, clear
syms x
f1 = (0.95 - 0.34*x) / 0.27;
f2 = (1.83 - 0.06*x) / 0.2;
%f3 = (0 + 0.08*x) / 4;
%f4 = (24 + 4*x) / 6;

figure(1)
hold on
fplot(f1, 'r')
fplot(f2, 'r')
%fplot(f3, 'r')
%fplot(f4, 'r')
plot([-3.86 -3.86],[-5 10], 'r')
grid on
xlim([-5 10])
ylim([-5 10])
xlabel('x_5')
ylabel('x_4')

plot([0 0],[0 10], 'b')
plot([10 0],[0 0], 'b')

%% изображаем целевую функцию и ее градиент
Z0 =  -0.980769*x;

%plot([0 3*1.56],[0 3*1.53], '--g')
fplot(Z0, color = 'g', LineStyle='--')
quiver(0, 0, 3*1.56, 3*1.53, Color='k')

%% смещаем линию уровню по направлению градиента целевой функции
Z = -0.980769*x + (0.95/0.34);
fplot(Z, color = 'g', LineStyle='-')
plot((0.95/0.34),0, '*', color='k')
hold off
