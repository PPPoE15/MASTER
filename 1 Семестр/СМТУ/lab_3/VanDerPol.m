function dx = VanDerPol(t, x, a, A, w)
    U = A*sin(w*t);
    dx = zeros(2, 1);
    dx(1) = x(2);
    dx(2) = a * (1 - x(1)^2) * x(2) - x(1) + U;
end