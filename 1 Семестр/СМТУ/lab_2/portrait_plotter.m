function portrait_plotter(sys, points, style)
    n = 20;
    plot(points(:,1),points(:,2), '.', 'MarkerSize', 15, color = 'b')
    hold on
    switch style
        case "points"
            Tspan = [0 1];
            options = odeset('RelTol',1e-1,'AbsTol',1e-1);
            for i = linspace(min(points(:,1)) - 1, max(points(:,1)) + 1, n)
                for j = linspace(min(points(:,2)) - 1, max(points(:,2)) + 1, n)
                    X0 = [i, j];
                    [~, x] = ode45(sys,Tspan,X0, options);
                    plot(x(:,1),x(:,2), ':', color = 'r');
                end
            end
            xlim([min(points(:,1)) - 1 max(points(:,1)) + 1])
            ylim([min(points(:,2)) - 1 max(points(:,2)) + 1])
        case "arrows"
            for i = linspace(min(points(:,1)) - 1, max(points(:,1)) + 1, n)
                for j = linspace(min(points(:,2)) - 1, max(points(:,2)) + 1, n)
                    X0 = [i, j];
                    u = sys(0, X0);
                    quiver(i, j, u(1), u(2), 0.05, 'b', AutoScale='on')
                    axis equal
                end
            end
            xlim([min(points(:,1)) - 1 max(points(:,1)) + 1])
            ylim([min(points(:,2)) - 1 max(points(:,2)) + 1])
    end
end