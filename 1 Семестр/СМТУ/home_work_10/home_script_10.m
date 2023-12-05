clc, clear, close all
syms x y a
x = [x y];

sys = @ (t,x) [x(2); -x(1) * (a*(x(2) + 1) + x(1)^2 - 1)];
f = [x(2); -x(1) * (a*(x(2) + 1) + x(1)^2 - 1)];



A(1,1) = diff(f(1),x(1));
A(1,2) = diff(f(1),x(2));
A(2,1) = diff(f(2),x(1));
A(2,2) = diff(f(2),x(2));


% [points, type] = special_points(f, x)
% portrait_plotter(sys, points, "points")