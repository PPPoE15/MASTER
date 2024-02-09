clc, clear, close all
syms x y z

x = [x y z];

x0 = [2 3 4];
sys = @ (t,x) [x(2); 0.5*x(3); -2*x(1) - 4*x(2) - 3*x(3)];
[t, y] = ode45(sys,[0 5],x0);

A = [0  1  0;
     0  0  0.5;
    -2 -4 -3];


plot(t, y(1), '.b',t, y(2), '.r',t, y(3), '.k')


S = dsolve('Dx1=x2','Dx2=0.5*x3',' Dx3=-2*x1-4*x2-3*x3', ...
    'x1(0)=2','x2(0)=0','x3(0)=0')
