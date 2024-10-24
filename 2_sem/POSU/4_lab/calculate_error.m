function error = calculate_error(ks0)
global X_START X_END TIME_END
[t, x] = ode45('ode_fun', [0 TIME_END], [X_START ks0]);
 
error = [x(end, 1) - X_END(1), x(end, 2) - X_END(2)];
error = error(1)^2 + error(2)^2;
 
plot(t, [x calculate_u([x(:,3) x(:,4)])])
legend('x1', 'x2', 'ks1', 'ks2', 'u')
grid on; xlabel('t'); ylabel('x, ks, u');
% pause(0.1)
end
