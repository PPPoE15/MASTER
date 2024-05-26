function dxdt = ode_fun(t, x)
    u = calculate_u([x(3), x(4)]);
    dxdt = [-2*x(2)+u;
            -x(2)+u;
            0;
            -2*x(3)-x(4)];
end