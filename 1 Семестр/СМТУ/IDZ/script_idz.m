clc, clear, close all

[A, B, C, D] = linmod('wieght_functions')
sys = ltisys(A, B, C, D)
sys = sderiv(sys, 2, [0.01 0.2 1])
[gopt,K] = hinflmi(sys, [1 1])
[num, denum] = ltitf(K)
