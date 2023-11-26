clc, clear, close all
syms a b x

% f = a*x - x^3
% f = (a-1)*x-x^2
% f = x^2 + 0.25*a - 1
f = a*sin(x) + b*sin(x)^2;  %  periodic function
% f = a*x^2 - 2*(a+1)*x + 3*a - 1

A = [-3, 3]; % range a
nA = 10; % num a points
B = [-3, 3]; % range b
nB = 10; % num b points
mode = 2; % 1 - one parameter, 2 - two parameters

switch mode
    case(1)
        figure(1)
        hold on
        for i = linspace(A(1,1),A(1,2),nA)
            g = subs(f, a, i);
            [coord, type] = special_points(g, x);
            for j = 1:size(type, 1)
                if(type(j,1) == "unstable")
                    plot(i, coord(j,1), 'b.')
                else
                    plot(i, coord(j,1), 'r.')
                end
            end
        end
        xlabel('a')
        ylabel('f')
        grid on
        hold off

    case(2)
        figure(1)
        hold on
        for i = linspace(A(1,1),A(1,2),nA)
            g = subs(f, a, i);
            for k = linspace(B(1,1),B(1,2),nB)
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
        xlabel('a')
        ylabel('b')
        zlabel('f')
        grid on
        hold off
end

