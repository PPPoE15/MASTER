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



