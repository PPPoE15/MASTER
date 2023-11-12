function D = frac_dim(x, r, N)
C = 0;
    for i = 1:N
        for j = 1:N
            if(i ~= j)
                dist = sqrt(  (x(j, 1)-x(i, 1))^2 + ...
                            (x(j, 2)-x(i, 2))^2 + ...
                            (x(j, 3)-x(i, 3))^2);
                if (r - dist > 0)
                    C = C + 1;
                end
            end
        end
    end
    C = C / N / (N - 1);
    D = log(C)/log(r);
end