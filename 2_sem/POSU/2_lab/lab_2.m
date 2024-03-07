clc, clear, close all
% % syms x y 
% x = -10:0.1:10;
% y = x;
% [X,Y] = meshgrid(x,y);
% Z = X.^2 + Y.^2 + X + Y + 1;
% z = x.^2 + y.^2 + x + y + 1;
% f = exp(-0.1.*(x.^2 + y.^2 + x + y + 1)).*cos(x.^2 + y.^2 + x + y + 1);
% F = exp(-0.1.*(X.^2 + Y.^2 + X + Y + 1)).*cos(X.^2 + Y.^2 + X + Y + 1);
% % f = exp(-0.1.*z).*cos(z);
% hold on
% surf(F)
% % contour(X,Y,Z,[1 2 3]);
% grid on
% 
% clear
% h_costf = @(x) (exp(-0.1.*(x(1).^2 + x(2).^2 + x(1) + x(2) + 1)) ...
%     .*cos(x(1).^2 + x(2).^2 + x(1) + x(2) + 1));
% X = fminsearch(h_costf,[0,0])
% 
% plot3(X(1),X(2), 0,'*')

z=0:0.01:10;
x0=[0 0];
m = fminsearch('func', x0)
x=m(1);
y=m(2);
f = x^2 + y^2 + x + y + 1;
output = exp(-0.1*f).*cos(f);
plot(z,cos(z).*exp(-0.1*z),f,output,'ro')
grid on

