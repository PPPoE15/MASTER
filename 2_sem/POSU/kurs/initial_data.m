V0 = 2.57; % м/c скорость хода
L = 99.6; % м, длина по ватерлинии

r21 = -0.58;
r31 = 6.16;
q21 = 0.80;
q31 = -7.23;
s21 = -0.34;
s31 = -3.5;

r21 = r21*1.1;

WW = V0/L; %Нормирующая частота

%% Соотношение параметров в нормированном и нормальном времени 
a11 = -r31*WW;
a12 = -q31*WW^2;
a21 = -r21;
a22 = -q21*WW;
b11 = -s31*WW^2;
b21 = -s21*WW;

%% Матриицы мат.модели с-мы в реальном времени
A = [a11 a12 0; a21 a22 0; 1 0 0];
B = [b11; b21; 0];

%% Собственные значения системы
% eig(A);
