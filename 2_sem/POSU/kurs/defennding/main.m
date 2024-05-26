clc,clear, close all;
global A B X_START X_END TIME_END
X_START = [1 0]; X_END = [0 0]; TIME_END = 1.5;
A = [0 -2; 0 -1]; B = [1 1];
ks0 = [0 0];
y = fminsearch('calculate_error', ks0)


