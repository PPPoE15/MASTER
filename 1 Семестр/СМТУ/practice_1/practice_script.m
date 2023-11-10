clc, clear, close all
x_0 = 0.45;
y_0 = 0;
c = 0.1;
T = 20;



sys = @(t,x) [  x(1)*(c+2*(x(1)^2+x(2)^2) -(x(1)^2+x(2)^2))^2 - 2*pi*x(2); 
                x(2)*(c+2*(x(1)^2+x(2)^2) -(x(1)^2+x(2)^2))^2 + 2*pi*x(1)];

[t, sol] = ode45(sys, [0 T], [x_0 y_0]);
figure(1)
plot(sol(:,1),sol(:,2))
grid on
figure(2)
plot(t,sol(:,1),t,sol(:,2))
grid on
