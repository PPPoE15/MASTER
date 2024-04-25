function z=costfunc(Tvec)
    global u_max
    t1 = Tvec(1); t2 = Tvec(2); T = Tvec(3);
    u_t = @(t) -u_max*[(t<t1)-(t>=t1)+2*(t>=t2)]*(t<T);
    rp_ode = @(t,x) [2*x(2); x(3); u_t(t)-x(2)-2*x(3)];
    [t,x]=ode45(rp_ode,[0 15],[8 0 0]);
    z= x(end,:)*[x(end,:)]';
    plot(t,x(:,1),'k',t,x(:,2),'k--',t,x(:,3),'k:')