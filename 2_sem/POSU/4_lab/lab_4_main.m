clc,clear, close all;
global A B X_START X_END TIME_END
X_START = [1 0]; X_END = [0 0]; TIME_END = 3;
A = [0 1; 0 -2]; B = [0 1];
ks0 = [0 0];
fminsearch('calculate_error', ks0)
S = dsolve('Dx1=-x2', ...
           'Dx2 = -2*x2+0.5*ks1+0.5*ks2', ...
           'Dks1 = 0', ...
           'Dks2 = ks1+2*ks2', ...
           'x1(0) = 1', ...
           'x2(0) = 0', ...
           'x1(3) = 0', ...
           'x2(3) = 0');
% S.x1, S.x2, S.ks1, S.ks2
t = 0:0.1:3;
figure(2)
hold on
ezplot(S.x1, [0, 3])
ezplot(-S.x2, [0, 3])
ezplot(-S.ks1, [0, 3])
ezplot(-S.ks2-4, [0, 3])
ylim([-4 2])
grid on
