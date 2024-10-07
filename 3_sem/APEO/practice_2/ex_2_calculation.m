U1 = 220;
U2 = 4.5;
f = 50;
s = 0.05;
p = 2;
Rst = 2.4;
Xst = 1i*2.8;
Rrt = 1.3;
Xrt = 1i*4.6;
Xm = 1i*50;

omega = 2*pi*f;

Z1 = calc_schema(Rst, Xst, Xm, Xrt, Rrt/s);
Z2 = calc_schema(Rst, Xst, Xm, Xrt, Rrt/(2-s));
Y1 = 1/Z1;
Y2 = 1/Z2;

M2_w1 = 1 / omega * 3*p*U1*U2 * abs(Y1 - Y2)
K_op = U2 / U1


function x = calc_paralel(x1, x2)
    x = (x1*x2) / (x1 + x2);
end

function z = calc_schema(Rst, Xst, Xm, Xrt, s)
    z = Rst + Xst + calc_paralel(Xm, Xrt+s);
end