function dxdt = ode_fun(t, x)
%     global A B
    u = calculate_u([x(3), x(4)]);
    dxdt = [-2*x(2)+u;
            -x(2)+u;
            0;
            -2*x(3)-x(4)];
end



% dxdt = [A(1,1)*x(1) + A(1,2)*x(2) + B(1)*u; ...
%             A(2,1)*x(1) + A(2,2)*x(2) + B(2)*u; ...
%             -A(1,1)*x(3) - A(2,1)*x(4); ...
%             -A(1,2)*x(3) - A(2,2)*x(4)];