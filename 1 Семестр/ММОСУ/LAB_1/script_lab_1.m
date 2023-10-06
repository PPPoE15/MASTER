clear, clc
sys = 'trim_model_lab_1';
a11 = -3;
a12 = -2;
a21 = -5;
a22 = -6;

b11 = 3;
b12 = 7;

x0 = [1;1];
u0 = 0.6277;
y0 = [];

[x,u,y,dx] = trim(sys, x0, u0, y0,[],[1],[])
[A,B,C,D] = linmod(sys, x, u)
sA = eig(A)
syms x1 x2
s = solve (a11*x1 + a12*x2^2 + b11*u == 0, a21*x1 + a22*x2^2 + b12*u == 0);
X1 = s.x1
X2 = s.x2