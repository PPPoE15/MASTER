function [y, i] = min_nevaz (A1, f1, y, B)
    % A1 - system of linear algebraic equations
    % f1 - right vector
    % y  - approximate value vector
    % B  - weight matrix

    switch nargin 
        case 2  % default y and B parameters
            B = eye(4);
            y = [6;1;6;1];
        case 3  % default B parameters
            B = eye(4);
        case 4  % got all parameters
            % do nothing
        case 0  % default parameters
            rng(9492)
            A1 = rand(4)*10 - 5;
            f1 = [9;4;9;2];
            B = eye(4);
            y = [6;1;6;1];
    end

    A = A1' * A1;
    f = A1' * f1;
    
    i = 0;  % iteration counter
    e = 1;  % precision
    while e > 0.001
        r = A * y - f;
        w = B\r;
        t = ((A*w)' * w) / ((B^-1 * A * w)' * (A*w));
        y = y + inv(B) * (f - (A*y))* t;
        e = norm(r);
        i = i + 1;
    end
end