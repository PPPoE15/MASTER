clc, close all
syms x
f1 = 2*x^6 - x^4 - 5*x^2 - 2;
f2 = (x^2 - 3*x + 1)^2 + 3*(x - 1)*(x^2 - 3*x + 1) - 4*(x - 1)^2;
f3 = (x - 1)^4 + (x - 3)^4 - 82;
f4 = sin(x) + cos(x);
f5 = sin(x) + (sin(x))^2 + (cos(x))^3;
f = [f1 f2 f3 f4 f5];
legend = 'o - stable';
legend = [legend newline  'x - unstable'];
for i = 1:5
    disp(f(i))
    [points, isStable] = special_points(f(i), x)
    figure(i)
    hold on
    fplot(f(i))
    ylim([-5 5])
    for j = 1:size(points,1)
         if isStable(j) == 'stable'
            plot(points(j),0,'ro','MarkerSize', 7)
            text(3,4,legend)
        else
            plot(points(j),0,'kx','MarkerSize', 7)
         end
         text(points(j),-1 + 2.*rand,sprintf(' % -.2g', points(j)),HorizontalAlignment='center')
    end
    grid on
    name = sprintf('portrait%d .jpg', i);
    saveas(i, name);
    hold off
end