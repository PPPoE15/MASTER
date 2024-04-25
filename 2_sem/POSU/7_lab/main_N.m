clear, clc, close all
global u_max
u_max = 1.4;
t1=4;
u_t = @(t) u_max*[(t<t1)-(t>=t1)];
odefun =@(t,x) [2*x(2);x(3);u_max-x(2)-2*x(3)];
%Интегрирование в обратном времени
[t,x] = ode45(odefun, [10:-0.01:0], [0 0 0]);
figure(1)
plot(x(:,2),x(:,3),'k--')
xt2=x(:,2);
xt3=x(:,3);
hold on

odefun =@(t,x) [2*x(2); x(3); u_t(t)-x(2)-2*x(3)];
%Интегрирование в прямом времени
[t,x] = ode45(odefun, [0:0.01:10], [8 0 0]);
plot(x(:,2),x(:,3),'k')
xlabel('x2')
ylabel('x3')
legend('Линия пререключения','Фазовая траектория в прямом времени')
xlim([min(x(:,2)) max(x(:,2))])
ylim([min(x(:,3)) max(x(:,3))])
% Определение t2
[x20,x30]=ginput(1);
del=abs(x30*ones(size(x(:,3))))-abs(x(:,3));

[M,I]=min(abs(del));
t2=t(I);
% Определение T
u_t = @(t) -u_max*[(t<t1)-(t>=t1)+2*(t>=t2)];
odefun = @(t,x) [2*x(2);x(3);u_t(t)-x(2)-2*x(3)];
[t,x] = ode45(odefun, [0 15], [8 0 0]);
figure(2)
plot(t,x(:,1),'k',t,x(:,2),'k--',t,x(:,3),'k:')
xlabel('t')
ylabel('x')
legend('x1(t)','x2(t)','x3(t)')
[M,I]=min(abs(x(:,1)));
T=t(I);
% Построение конечных переходных процессов
u_t = @(t) -u_max*[(t<t1)-(t>=t1)+2*(t>=t2)]*(t<T);
odefun =@(t,x) [2*x(2);x(3);u_t(t)-x(2)-2*x(3)];
[t,x] = ode45(odefun, [0 15], [8 0 0]);
figure(3)
plot(t,x(:,1),'k',t,x(:,2),'k--',t,x(:,3),'k:')
xlabel('t')
ylabel('x')
legend('x1(t)','x2(t)','x3(t)')
%определение величины x1T1
x1T1=x(end,1)

%% fminsearch

t0=[t1 t2 T];
figure(4)
T=fminsearch('costfunc',t0);
xlabel('t')
ylabel('x')
legend('x1(t)','x2(t)','x3(t)')
grid on

