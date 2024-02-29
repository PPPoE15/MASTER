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
plot(t,sol(:,1),t,sol(:,2),t,sol(:,3))
grid on

syms x1 x2 x3 dx1 dx2 dx3 s


A = [0 1 0;
     0 0 0.5;
     -2 -4 -3]
% dx1 = x2;
% dx2 = 0.5*x3;
% dx3 = -2*x1 -4*x2 -3*x3;
% s*x1 -x2 = 2
% s*x2 -0.5*x3 = 0
% s*x3 2*x1 + 4*x2 + 3*x3 = 0

delta1 = [2 -1 0; 
          0 s -0.5;
          0 4 s+3];

delta2 = [s 2 0; 
          0 0 -0.5;
          2 0 s+3];

delta3 = [s -1 2; 
          0 s 0;
          2 4 0];


delta = [s -1 0; 
          0 s -0.5;
          2 4 s+3];

ddelta = det(delta);
ddelta1 = det(delta1);
ddelta2 = det(delta2);
ddelta3 = det(delta3);
x1 = ddelta1/ddelta;
x2 = ddelta2/ddelta
x3 = ddelta3/ddelta
t = 0:0.01:20;
x1 = 2.*exp(-t)+2.*t.*exp(-t);
plot(t,x1)