clc, clear, close all
syms a x y
x = [x y];
% f = a*x - x^3
% f = (a-1)*x-x^2
% f = x^2 + 0.25*a - 1
% f = a * (1 - x(1)^2) * x(2) - x(1);
% f = [x(2);  a*(1 - x(1)^2) * x(2) - x(1)];
f = [x(1)^2 - x(2)^2 - 5; a * x(1)^2 + x(2)^2 - 13];

A = [-1, 3]; % range a
nA = 50; % num a points


saddle_array = zeros(3,0);
unstable_node_array = zeros(3,0);
stable_node_array = zeros(3,0);
center_array = zeros(3,0);
unstable_focus_array = zeros(3,0);
stable_focus_array = zeros(3,0);

figure(1)
hold on
for i = linspace(A(1,1),A(1,2),nA)
    g = subs(f, a, i);
    [coord, type] = special_points(g, x);
    for j = 1:size(coord, 1)
            if(type(j,1) == "stable node")
                stable_node_array = [stable_node_array, [coord(1,j);coord(2,j);type(j)]];
                plot3(i, coord(j, 1), coord(j, 2), '.r');
            else
                plot3(i, coord(j, 1), coord(j, 2), '.b');
            end
    end
    
end
xlabel('a')
ylabel('x')
zlabel('y')
grid on
hold off

