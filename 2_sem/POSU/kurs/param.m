clear, clc, close all;
initial_data;

x0 = [0 0 10];
K0 = [100 100];
Um = 35;
T = 100;

[K, fval] = fminsearch(@(KK) costfun(KK, A,B,Um,x0), K0)
fun = @(t,x) A*[x(1);x(2);x(3)]+B*control_calc(x, Um, K);
[t,x] = ode45(fun, [0 T], x0);
figure(1)
plot(t,x); grid on; hold on;
alignment_angle = zeros(1,length(t));
for i = 1:length(t)
    alignment_angle(i) = control_calc(x(i,:), Um, K);
end
plot(t,alignment_angle, '--k'); grid on
legend('x_1', 'x_2', 'x_3', 'u');
t = t_per_proc(t, x, 3)

function f = costfun(K, A, B, umax, x0)
    fun = @(t,x) A*[x(1);x(2);x(3)]+B*control_calc(x, umax, K);
    [t,x] = ode45(fun, [0 100], x0);
    f = t_per_proc(t, x, 3);
end

function f = t_per_proc(t, x, j)
    for i=length(x):-1:1
        if abs(x(i,j))>0.05*10
            f = t(i);
            break
        end
    end
end

function u = control_calc(x, umax, K)
    u = -K(1)*x(3)-K(2)*x(1);
    if abs(u)>umax
        u = umax*sign(u);
    end
end
