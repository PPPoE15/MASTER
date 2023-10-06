clc, clear 
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


% closed loop system
sys = lft(sys_ob,sys_reg);

C_sys = [0 0 1 0];
D_sys = 0;
B_sys = [  0;
           0;
           0;
           -k3];
set(sys, 'C', C_sys);
set(sys, 'D', D_sys);
set(sys, 'B', B_sys);
sys
H_sys = tf(sys)

% modeling

s = stepinfo(sys);
s.RiseTime  % время нарастания
s.SettlingTime  % время установления
s.Peak  % установившееся значение
