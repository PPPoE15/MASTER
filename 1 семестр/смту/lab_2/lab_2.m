clc, clear
sys = @ (t,x) [2*x^6 - x^4 - 5*x^2 - 2];
Tspan = [0 1];
X0 = [1.4143];
[t, x] = ode45(sys,Tspan,X0);
plot(t,x)

% hold on
% for i=0:5
%     for j=0:5
%         u = sys(0,[i j]);
%         quiver(i,j,u(1),u(2),0.1)
%     end
% end
% %quiver()