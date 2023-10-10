clc, clear
sys = @ (t,x) [0.25*x(1); -3*x(2)];
Tspan = [0 1];
X0 = [0, 0];
[t, x] = ode45(sys,Tspan,X0);
plot(x(:,1),x(:,2), '.')

% hold on
% for i=0:5
%     for j=0:5
%         u = sys(0,[i j]);
%         quiver(i,j,u(1),u(2),0.1)
%     end
% end
% %quiver()