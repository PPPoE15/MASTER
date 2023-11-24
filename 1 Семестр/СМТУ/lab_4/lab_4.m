clc, clear, close all
syms a b x

%f = a*x - x^3
%f = (a-1)*x-x^2
% f = x^2 + 0.25*a - 1
f = x^8 + a*x^4 + b

figure(1)
hold on
for i = 1:0.5:5
    g = subs(f, a, i);
    for k = 1:0.5:5
        g = subs(g, b, k);
        [coord, type] = special_points(g, x);
        for j = 1:size(type, 1)
            if(type(j,1) == "unstable")
                plot3(i,k, coord(j,1), 'b.')
            else
                plot3(i,k, coord(j,1), 'r.')
            end
        end
    end
end