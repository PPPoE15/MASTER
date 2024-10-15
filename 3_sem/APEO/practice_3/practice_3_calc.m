clc, clear
U1 = 220;
U5 = 38;
U7 = 27;
U11 = 18;
U13 = 15;
U17 = 12;
U19 = 7;
f = 50;
p = 2;
x_st = 2.7;
x_rt = 3.5;

q = abs([-5, 7, -11, 13, -17, 19]);

omega = 2*pi*f;
beta = omega/2/pi/50;

for i = 1:length(q)
    Z(i) = calc_z(q(i), beta, x_st + x_rt);
end

k = 3*p*U1/ omega;

M_6w1 = k * (U5/Z(1) - U7/Z(2))
M_12w1 = k * (U11/Z(3) - U13/Z(4))
M_18w1 = k * (U17/Z(5) - U19/Z(6))


function Z = calc_z(q, beta, x)
    Z = q*beta*x;
end
