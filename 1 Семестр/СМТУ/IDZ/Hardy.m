clc, clear
syms w s
W = (6*s + 10) / (s+5) / (s^2 + 4*s + 30)
W1 = subs(W, s, 1i*w);
W2 = subs(W, s, -1i*w);
W_abs = simplify(W1*W2)

