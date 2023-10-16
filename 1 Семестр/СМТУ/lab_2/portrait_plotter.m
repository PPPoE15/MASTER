function portrait_plotter(sys)
    Tspan = [0 1];
    hold on
    for i = -10:10
        for j = -10:10
            X0 = [i, j];
            [~, x] = ode45(sys,Tspan,X0);
            plot(x(:,1),x(:,2), '.');
        end
    end
    xlim([-20 20])
    ylim([-20 20])
end