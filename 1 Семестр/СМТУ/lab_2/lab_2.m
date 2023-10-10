clc, clear
sys = @ (t,x) [x(1)^2 - x(2)^2 - 5; x(1)^2 + x(2)^2 - 13];
Tspan = [0 1];
X0 = [0, 0];
[t, x] = ode45(sys,Tspan,X0);
plot(x(:,1),x(:,2), '.')

hold on
for i = -5:10
    for j = -5:10
        u = sys(0,[i j]);
        quiver(i,j,u(1),u(2),0.1)
    end
end
%quiver()