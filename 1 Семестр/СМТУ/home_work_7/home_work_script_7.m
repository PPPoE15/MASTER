clc, clear, close all










syms a b fi k
f1 = a*sin(fi) + b*(sin(fi))^2;
f1 = simplify(f1)
r = solve(f1, fi, "ReturnConditions",true)
% f2 = subs(f1, a, 0);
% f2 = subs(f2, b, 1)
% fplot(f2)
% hold on
% xlim([0 2*pi])
% plot(pi+asin(1),0,'*')
% plot(2*pi-asin(1),0,'*')
% plot(0,0,'*')
% grid on

df = diff(f1,fi)
df = simplify(df)

% 
% df1 = simplify(subs(df,fi, r.fi(1,1)));
% df2 = simplify(subs(df,fi, r.fi(2,1)));
% df3 = simplify(subs(df,fi, r.fi(3,1)));
% 
% df1 = subs(df1, b, 1)
% df2 = subs(df2, b, 1)
% df3 = subs(df3, b, 1)
% 
% %% a = 1
% df1 = simplify(subs(df1, a, 1));
% df1 = cos(pi*k) + 1
% 
% df2 = simplify(subs(df2, a, 1));
% df2 = 0
% 
% df3 = simplify(subs(df3, a, 1));
% df3 = 0
% 
% 
% %% a = 0
% df1 = simplify(subs(df1, a, 0));
% df1 = 0
% df2 = simplify(subs(df2, a, 0));
% df2 = 0
% df3 = simplify(subs(df3, a, 0));
% df3 = 0
% 
% %% a = -1
% df1 = simplify(subs(df1, a, -1))
% df2 = simplify(subs(df2, a, -1))
% df3 = simplify(subs(df3, a, -1))