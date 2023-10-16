clc, clear, close all
disp('Задание 1')
syms x y
args = [x y];
f = [x^2 - y^2 - 5, x^2 + y^2 - 13];
[points, eig] = special_points(f, args)
figure(1)
plot(points(:,1),points(:,2),'.')
ylim([-5 5])
xlim([-5 5])
grid on

disp('Задание 2')
syms x y
args = [x y];
f = [0.25*x, -3*y];
[points, eig] = special_points(f, args)
figure(2)
plot(points(:,1),points(:,2),'.')
grid on
