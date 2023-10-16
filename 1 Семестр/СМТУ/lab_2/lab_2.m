clc, clear, close all
syms x y
x = [x y];
sys = @ (t,x) [x(1)^2 - x(2)^2 - 5; x(1)^2 + x(2)^2 - 13];
f = [x(1)^2 - x(2)^2 - 5; x(1)^2 + x(2)^2 - 13];
[points, type] = special_points(f, x)
portrait_plotter(sys)