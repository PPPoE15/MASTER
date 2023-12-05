clc, clear,close all
syms r a

f = r*(a-1+2*r^2-r^4)


A = [-1, 2]; % range a
nA = 100; % num a points

figure(1)
hold on
for i = linspace(A(1,1),A(1,2),nA)
    g = subs(f, a, i);
    [coord, type] = special_points(g, r);
    for j = 1:size(type, 1)
        if(coord(j,1) == 0)
            if(type(j,1) == "unstable" )
                plot(i, coord(j,1), 'b*')
            else
                plot(i, coord(j,1), 'r*')
            end
            continue
        end
        if (coord(j,1) > 0)
            if(type(j,1) == "unstable" )
                plot(i, coord(j,1), 'b.')
            else
                plot(i, coord(j,1), 'r.')
            end
        end
    end
end
xlabel('a')
ylabel('r')
ylim([-0.5 2])
grid on
hold off

df = simplify(diff(f,r))
roots = simplify(solve(f,r))
r1 = [roots(1);roots(3);roots(5)]
df1 = simplify(subs(df, r1))

% figure(2)
% hold on
% syms x y
% x = [x y];
% a = 1;
% sys = @ (t,x) [x(1) * (a - 1 + 2*(x(1)^2 + x(2)^2) - (x(1)^2 + x(2)^2)^2) - 2*pi*x(2); 
%                x(2) * (a - 1 + 2*(x(1)^2 + x(2)^2) - (x(1)^2 + x(2)^2)^2) + 2*pi*x(1)];
% f = [x(1) * (a - 1 + 2*(x(1)^2 + x(2)^2) - (x(1)^2 + x(2)^2)^2) - 2*pi*x(2); 
%                x(2) * (a - 1 + 2*(x(1)^2 + x(2)^2) - (x(1)^2 + x(2)^2)^2) + 2*pi*x(1)];
% [points, type] = special_points(f, x);
%          
% 
% 
% 
% % Tspan = [0 40];
% % X0 = [0.9, 0.9];
% % 
% % [~, x] = ode45(sys,Tspan,X0);
% % plot(x(:,1),x(:,2), ':', color = 'r');
% 
% portrait_plotter(sys, points, "points")
 