clc, clear, close all
syms a x y
x = [x y];

f = [x(2); -x(1) * (a*(x(2) + 1) + x(1)^2 - 1)];

A = [-0.5, 1.5]; % range a
nA = 50; % num a points


saddle_array = zeros(3,0);
unstable_node_array = zeros(3,0);
stable_node_array = zeros(3,0);
center_array = zeros(3,0);
unstable_focus_array = zeros(3,0);
stable_focus_array = zeros(3,0);


for i = linspace(A(1,1),A(1,2),nA)
    g = subs(f, a, i);
    [coord, type] = special_points(g, x);
    if(size(coord,1) > 0)
        for j = 1:size(type, 1)
            switch(type(j,1)) 
                case "stable node"
                    stable_node_array =     [stable_node_array,      [i; coord(j,1); coord(j,2)]];
                
                case"unstable node"
                    unstable_node_array =   [unstable_node_array,    [i; coord(j,1); coord(j,2)]];
            
                case "saddle"
                    saddle_array =          [saddle_array,           [i; coord(j,1); coord(j,2)]];
            
                case "center"
                    center_array =          [center_array,           [i; coord(j,1); coord(j,2)]];
            
                case "unstable focus"
                    unstable_focus_array =  [unstable_focus_array,   [i; coord(j,1); coord(j,2)]];
            
                case "stable focus" 
                    stable_focus_array =    [stable_focus_array,     [i; coord(j,1); coord(j,2)]];
            end
        end
    end
end

figure(1)
hold on
plot3(saddle_array(1,:),saddle_array(2,:),saddle_array(3,:), "square",'color', 'k','DisplayName','saddle')

plot3(unstable_node_array(1,:),unstable_node_array(2,:),unstable_node_array(3,:), 'xb','DisplayName','unstable node')
plot3(stable_node_array(1,:),stable_node_array(2,:),stable_node_array(3,:), 'xr','DisplayName','stable node')

plot3(center_array(1,:),center_array(2,:),center_array(3,:), 'og','DisplayName','center')

plot3(unstable_focus_array(1,:),unstable_focus_array(2,:),unstable_focus_array(3,:), '.b','DisplayName','unstable focus')
plot3(stable_focus_array(1,:),stable_focus_array(2,:),stable_focus_array(3,:), '.r','DisplayName','stable focus')

legend
xlabel('a')
ylabel('x')
zlabel('y')
grid on
hold off

