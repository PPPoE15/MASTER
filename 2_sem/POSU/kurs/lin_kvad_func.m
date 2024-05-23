clear, clc, close all;
initial_data;

x0 = [0 0 10];
Um = 35;
lambda = 1;
 
[lam, fval] = fminsearch(@(l_) costfun(l_, A,B,Um,x0), lambda)
Q = zeros(3,3);
Q(3,3) = lam
K = lqr(A,B,Q,1)
fun = @(t,x) A*[x(1);x(2);x(3)]+B*control_calc(x, Um, K);
[t,x] = ode45(fun, [0 40], x0);
figure(1)
plot(t,x); grid on; hold on;
for i = 1:length(t)
    uu(i) = control_calc(x(i,:), Um, K);
end
plot(t,uu, '--k'); grid on
legend('x_1', 'x_2', 'x_3', 'u');
t_trans = transition_time(t, x, 3)

function f = costfun(lambda, A, B, umax, x0)
    Q = zeros(3,3);
    Q(3,3) = lambda;
    K = lqr(A,B,Q,1);
    fun = @(t,x) A*[x(1);x(2);x(3)]+B*control_calc(x, umax, K);
    [t,x] = ode45(fun, [0 200], x0);
    f = transition_time(t, x, 3);
end

function t_trans = transition_time(t, x, j)
    for i=length(x):-1:1
        if abs(x(i,j))>0.05*10
            t_trans = t(i);
            break
        end
    end
end

function u = control_calc(x, umax, K)
    u = -K(1)*x(1)-K(2)*x(2)-K(3)*x(3);
    if abs(u)>umax
        u = umax*sign(u);
    end
end
