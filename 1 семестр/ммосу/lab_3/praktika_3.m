clc, clear
disp('Вызов функции с двумя аргументами:')
rng(9492)
A = rand(4)*10 - 5;
f = [9;4;9;2];
[y, i] = min_nevaz(A, f)


disp('Вызов функции без аргументов:')
[y, i] = min_nevaz()


