clc, clear, close all
syms x y a M0 I
x = [x y];


sys = @ (t,x) [x(2); (M0 + a*x(2))/I];
f = [x(2); (M0 + a*x(2))/I];

A(1,1) = diff(f(1),x(1));
A(1,2) = diff(f(1),x(2));
A(2,1) = diff(f(2),x(1));
A(2,2) = diff(f(2),x(2));
df = diff(f)

roots = solve(f(2), x(2))

% [points, type] = special_points(f, x)
% portrait_plotter(sys, points, "points")