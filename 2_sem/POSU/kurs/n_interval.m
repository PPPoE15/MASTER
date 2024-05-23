clear, clc
close all;
initial_data;

x0 = [0 0 10];
Um = 35;
T = 50;
t_sw_1 = 19;
direct_time = @(t,x) A*[x(1); x(2); x(3)]+B*Um*(-(t<t_sw_1)+(t>=t_sw_1));
[t1,x1] = ode45(direct_time, 0:0.001:T, x0);

reverse_time = @(t,x) A*[x(1); x(2); x(3)]-B*Um;
[t2,x2] = ode45(reverse_time, T:-0.001:0, [0 0 0]);

figure(1)
plot3(x1(:,1), x1(:,2), t1, '--k', x2(:,1), x2(:,2), t2, 'r'); grid on
legend('Прямое интегрирование', 'Обратное интегрирование')
xlabel('x_1'); ylabel('x_2')
axis([-10 10 -10 10])
view([0 90])

t_sw_2 = 47
T_off = 48

u = @(t) Um*(-(t<t_sw_1)+(t>=t_sw_1)-2*(t>=t_sw_2));
fun = @(t,x) A*[x(1); x(2); x(3)]+B*u(t);
[t,x] = ode45(fun, 0:0.001:T_off, x0);

figure(2)
plot(t,x, '--', t,  u(t)/35); grid on; hold on;
legend('x_1', 'x_2', 'x_3', 'u');
xlabel('t');

t_opt = [t_sw_1 t_sw_2 T_off];

[tt, fval] = fminsearch(@(tau) costfun(tau, A, B, Um, x0), t_opt)

u = @(t) Um*(-(t<tt(1))+(t>=tt(1))-2*(t>=tt(2)));
fun2 = @(t,x) A*[x(1); x(2); x(3)]+B*u(t);
[t,x] = ode45(fun, 0:0.001:T_off, x0);
[t_l,x_l] = ode45(fun2, 0:0.001:tt(3), x0);
figure(3)
plot(t_l,x_l, '--', t_l,  u(t_l)/35); grid on; hold on;
legend('x_1', 'x_2', 'x_3', 'u');
xlabel('t');

function f = costfun(t_opt, A, B, um, x0)
    t1 = t_opt(1); t2 = t_opt(2); T = t_opt(3);
    u = @(t) um*(-(t<t1)+(t>=t1)-2*(t>=t2));
    fun = @(t,x) A*[x(1) x(2) x(3)]'+B*u(t);
    [~, x] = ode45(fun, [0 T], x0);
    f = x(end,:)*x(end,:)';
end
