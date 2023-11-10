clc, clear, close all
x_0 = 10;
y_0 = -10;
z_0 = 10;
T = 800;
b = 0.19;


sys = @(t,x) [  -b*x(1) + sin(x(2)); 
                -b*x(2) + sin(x(3)); 
                -b*x(3) + sin(x(1))];

[t, sol] = ode45(sys, [0 T], [x_0 y_0 z_0]);
figure(1)
plot3(sol(:,1),sol(:,2),sol(:,3))
grid on
figure(2)
plot(t,sol(:,1),t,sol(:,2),t,sol(:,3))
grid on
