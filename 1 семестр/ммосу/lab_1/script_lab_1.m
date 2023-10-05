clear, clc
sys = 'trim_model_lab_1';
a11 = -3;
a12 = -2;
a21 = -5;
a22 = -6;

b11 = 3;
b12 = 7;

x0 = [1;1];
u0 = 1;
y0 = [];

[x1,u1,y1,dx1] = trim(sys, x0, u0, y0)
[A1,B1,C1,D1] = linmod(sys, x1, u1)

%% фиксация входного воздействия
[x2,u2,y2,dx2] = trim(sys, x0, u0, y0, [],[1],[])
[A2,B2,C2,D2] = linmod(sys, x1, u1)
[A2,B2,C2,D2] = linmod(sys)
sA = eig(A2)
syms x1 x2
s = solve (a11*x1 + a12*x2^2 + b11*u2 == 0, a21*x1 + a22*x2^2 + b12*u2 == 0);
X1 = s.x1
X2 = s.x2