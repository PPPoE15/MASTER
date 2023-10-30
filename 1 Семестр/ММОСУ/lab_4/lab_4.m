clc, clear, close all
a11 = -0.159;
a12 = 0.267;
a21 = 0.103;
a22 = -0.188;
b1 = -0.0215;
b2 = -0.0213;

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

sys_ob = ss(Ao, Bo, Co, Do);

%% modal regulator 1
s1 = -0.1;
s2 = -0.05;
s3 = -0.25-0.08i;
s4 = -0.25+0.08i;
p = [s1 s2 s3 s4];
K = -place(get(sys_ob, 'A'), get(sys_ob, 'B'), p);
sys_reg = ss(K);
sys = lft(sys_ob,sys_reg, 1, 4);

C_sys = [0 0 1 0];
D_sys = 0;
B_sys = [  0;
           0;
           0;
           -K(3)];
set(sys, 'C', C_sys, 'D', D_sys, 'B', B_sys);

hold on
step(sys, 'r')
pole_sys_1 = pole(sys)

%% modal regulator 2
s2 = -0.5;
p = [s1 s2 s3 s4];
K = -place(get(sys_ob, 'A'), get(sys_ob, 'B'), p);
sys_reg = ss(K);
sys = lft(sys_ob,sys_reg, 1, 4);

B_sys = [  0;
           0;
           0;
           -K(3)];
set(sys, 'C', C_sys, 'D', D_sys, 'B', B_sys);


step(sys,'b')
grid on
legend('s_2 = -0.05','s_2 = -0.5')
pole_sys_2 = pole(sys)