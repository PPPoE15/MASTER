function [points, stable] = special_points(func, arg)
    point_struct = struct2cell(solve(func, arg, 'Real',true, 'ReturnConditions',true));  % roots structure
    switch size(arg,2)
        case 1
            points = point_struct{1, 1};
            if size(point_struct{2, 1}, 2) > 0  % check if func is periodic
                period_counter = 0;  % periodic roots counter
                j = 0;  % integer iterator for periodic roots
                points = [];
                while period_counter < size(point_struct{1, 1},1)
                    for i = 1:size(point_struct{1, 1},1)
                        if subs(point_struct{1, 1}(i),point_struct{2, 1},j) < 2*pi && subs(point_struct{1, 1}(i),point_struct{2, 1},j) >= 0  % check if the root within the peroid
                            points = [points; subs(point_struct{1, 1}(i),point_struct{2, 1},j)];  % append new roots
                        else 
                            if subs(point_struct{1, 1}(i),point_struct{2, 1},j) >= 0
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

        case 2
            points = [point_struct{1, 1} point_struct{2, 1}];
            
            points = eval(points);
            A(1,1) = diff(func(1),arg(1));
            A(1,2) = diff(func(1),arg(2));
            A(2,1) = diff(func(2),arg(1));
            A(2,2) = diff(func(2),arg(2));
            a = [0; 0];
            for j = 1:size(points,1)
                
                A1 = subs(A,arg(1),points(j,1));
                A1 = eval(subs(A1,arg(2),points(j,2)));
                a(:,j) =   eig(A1);
            end
            
            stable = a';
    end
    
end
