clc, clear, close all
a11 = -0.159;
a12 = 0.267;
a21 = 0.103;
a22 = -0.188;
b1 = -0.0215;
b2 = -0.0213;
k1 = 10; k2 = 20; k3 = 5; k4 = -1;
k = [k1, k2, k3, k4];
phi_0 = 10; 
phi = phi_0;
%x = [  beta; 
%       omega, 
%       phi
%       delta];

% object
Ao = [a11   a12   0     b1;
      a21   a22   0     b2;
      0     1     0     0;
      0     0     0     0];

Bo = [  0;
        0;
        0;
        1];

Co = [  1 0 0 0;
        0 1 0 0;
        0 0 1 0;
        0 0 0 1];

Do = [  0;
        0;
        0;
        0];

sys_ob = ss(Ao, Bo, Co, Do)

% regulator
sys_reg = ss(k)

sys = lft(sys_ob,sys_reg, 1, 4);

C_sys = [0 0 1 0];
D_sys = 0;
B_sys = [  0;
           0;
           0;
           -k3];
set(sys, 'C', C_sys, 'D', D_sys, 'B', B_sys);
sys

%% modeling
figure(1)
grid on
hold on
step(sys)

figure(2)
grid on
hold on
plot(pole(sys), '*')

%% modal regulator
s1 = -0.1;
s2 = -0.05;
s3 = -0.25-0.08i;
s4 = -0.25+0.08i;
p = [s1 s2 s3 s4];
K = acker(get(sys, 'A'), get(sys, 'B'), p);
sys_reg = ss(K);
sys = lft(sys_ob,sys_reg, 1, 4);  % WARNING using lft is wrong, check it

C_sys = [0 0 1 0];
D_sys = 0;
B_sys = [  0;
           0;
           0;
           -K(3)];
set(sys, 'C', C_sys, 'D', D_sys, 'B', B_sys);

figure(1)
step(sys)

figure(2)
plot(pole(sys), '*')