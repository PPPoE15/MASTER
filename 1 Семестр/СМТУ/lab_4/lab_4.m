clc, clear, close all
syms a b x

f = x*(a - 1 + 2*x^2 - b*x^4)
%f = (1+a)*x^3 + b*x^2 + a*x
% f = (a-1)*x-x^2
% f = x^2 + 0.25*a - 1
% f = a*sin(x) + b*sin(x)^2;  %  periodic function
% f = a*x^2 - 2*(a+1)*x + 3*a - 1

A = [-1, 2]; % range a
nA = 50; % num a points
B = [-4, 2]; % range b
nB = 10; % num b points
mode = 1; % 1 - one parameter, 2 - two parameters

switch mode
    case(1)
        stable_array = zeros(2,0);
        unstable_array = zeros(2,0);
        figure(1)
        hold on
        for i = linspace(A(1,1),A(1,2),nA)
            g = subs(f, a, i);
            [coord, type] = special_points(g, x);
            for j = 1:size(type, 1)
                if(type(j,1) == "unstable")
                    unstable_array =     [unstable_array,      [i; coord(j,1)]];
                else
                    stable_array =     [stable_array,      [i; coord(j,1)]];
                end
            end
        end
        plot(unstable_array(1,:), unstable_array(2,:), '.b','DisplayName','unstable')
        plot(stable_array(1,:), stable_array(2,:), '.r','DisplayName','stable')
        xlabel('a')
        ylabel('f')

    case(2)
        stable_array = zeros(3,0);
        unstable_array = zeros(3,0);
        figure(1)
        hold on
        prog = 1;
        for i = linspace(A(1,1),A(1,2),nA)
            g = subs(f, a, i);
            disp(prog/nA/nB*100);
            for k = linspace(B(1,1),B(1,2),nB)
                g = subs(g, b, k);
                [coord, type] = special_points(g, x);
                for j = 1:size(type, 1)
                    if(type(j,1) == "unstable")
                        unstable_array =     [unstable_array,      [i; k; coord(j,1)]];
                    else
                        stable_array =     [stable_array,      [i; k; coord(j,1)]];
                    end
                end
                prog = prog + 1;
            end
            clc
        end
        plot3(unstable_array(1,:),unstable_array(2,:),unstable_array(3,:), '.b','DisplayName','unstable')
        plot3(stable_array(1,:),stable_array(2,:),stable_array(3,:), '.r','DisplayName','stable')
        xlabel('a')
        ylabel('b')
        zlabel('f')
       
end

legend
grid on
hold off
