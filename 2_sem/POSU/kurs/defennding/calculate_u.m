function u = calculate_u(ks)
global B
u = 0.5*(ks(:,1).*B(1) + ks(:,2).*B(2));
end
