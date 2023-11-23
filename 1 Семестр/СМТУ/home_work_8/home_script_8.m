clc, clear, close all
syms a x

f = a*x^2 - 2*(a+1)*x + 3*a - 1
r = solve(f, x)

r1 = subs(r, a, -1)
