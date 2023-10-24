function Attractor(a,b,c,x0,tmax)
    %x0 = [1; 1; 0];
    f = @(t,x) [-x(2)-x(3); x(1)+a*x(2); b+x(3)*(x(1)-c)];
    %[t,x] = ode45(f,[0 tmax],x0);
    [t,x] = Rossler(a,b,c,x0,tmax);  
    fig = figure(1);
    plot3(x(1,:),x(2,:),x(3,:),'-r'); hold all
    FP = FixedPoint(a,b,c);     % особые точки
    plot3(FP(1,1),FP(1,2),FP(1,3),'b*'); hold all   
    plot3(FP(2,1),FP(2,2),FP(2,3),'b*'); hold all   
    xlabel('x(t)'); ylabel('y(t)'); zlabel('z(t)');
    title(sprintf('Система Ресслера с параметрами a = %.1f, b = %.1f & c = %.1f',a,b,c));
    grid on;
    saveas(fig, sprintf('Система Ресслера с параметрами a = %.1f, b = %.1f & c = %.1f.png',a,b,c))
end