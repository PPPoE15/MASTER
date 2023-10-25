clc, clear, close all
x_0 = 10;
y_0 = 10;
z_0 = 10;
T = 100;
s = 10;
b = 8/3;
r = 20;

sys = @(t,x) [s*(x(2) - x(1)); x(1)*(r-x(3)) - x(2); x(1)*x(2) - b*x(3)];
[t, sol] = ode45(sys, [0 T], [x_0 y_0 z_0]);
figure(1)
plot3(sol(:,1),sol(:,2),sol(:,3))
grid on
figure(2)
plot(t,sol(:,1),t,sol(:,2),t,sol(:,3))
grid on
