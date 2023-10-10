function [points, stable] = special_points(func, arg)
    x = arg(1);
    point_struct = solve(func, arg, 'Real',true, 'ReturnConditions',true);  % roots structure
    points = point_struct.x;
    if size(point_struct.parameters, 2) > 0  % check if func is periodic
        period_counter = 0;  % periodic roots counter
        j = 0;  % integer iterator for periodic roots
        points = [];
        while period_counter < size(point_struct.x,1)
            for i = 1:size(point_struct.x,1)
                if subs(point_struct.x(i),point_struct.parameters,j) < 2*pi && subs(point_struct.x(i),point_struct.parameters,j) >= 0  % check if the root within the peroid
                    points = [points; subs(point_struct.x(i),point_struct.parameters,j)];  % append new roots
                else 
                    if subs(point_struct.x(i),point_struct.parameters,j) >= 0
                        period_counter = period_counter + 1;
                    end
                end
            end
            j = j + 1;
        end
    end
    points = eval(points);
    df = diff(func);
    stable = subs(df, arg, points);
    for i = 1:size(stable,1)
        if eval(stable(i)) < 0
            stable(i) = 'stable';
        else
            stable(i) = 'unstable';
        end
    end
end
