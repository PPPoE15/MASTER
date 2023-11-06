clear, clc, close all
syms x1 x2 x3 x4 x5
f = [3*x1 + x2 + x3 + x4 + x5 == 5; 2*x1 - x2 + 3*x3 == 4; 5*x2 + 6*x3 + x4 == 11;];
s = solve(f);
f1 = solve(s.x1);
f2 = solve(s.x2);
f3 = solve(s.x3);

hold on
fplot(f1)
fplot(f2)
fplot(f3)
plot([0 0],[0 10], 'b')
plot([10 0],[0 0], 'b')
grid on