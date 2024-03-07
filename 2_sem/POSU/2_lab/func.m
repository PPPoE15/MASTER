function output = func(x0)
    x = x0(1);
    y = x0(2);
    f = x^2 + y^2 + x + y + 1;
    output = exp(-0.1*f).*cos(f);
end




