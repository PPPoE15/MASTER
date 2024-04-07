clear all;
clc; 
close all;
K0=5;
T1=0.3;
T2=0.05;
Ts=0.01;
[a,b,c,d]=dlinmod('ish_block', Ts)
SYS=ss(a,b,c,d,Ts)
step(SYS,2.5)
hold on
%Останов
disp('Расчет полюсов для системы с модальным регулятором')
batterwort
pd=exp(p*Ts)%Вектор желаемых полюсов дискретной системы
Kd=place(SYS.A,SYS.B,pd)%коэффициенты модального регулятора
%Расчет нормирующего коэффициента
ydu=dcgain(SYS);  % Установившееся значение на выходе
                   % цифрового объекта
Adk = SYS.A - SYS.B*Kd;  % Матрица A замкнутой цифровой системы
Fd =ss(Adk,SYS.B,SYS.C,SYS.D,Ts); % Описание замкнутой цифровой
                         % системы
yduk=dcgain(Fd);   % Установившееся значение на выходе
                   % замкнутой цифровой системы
kdnorm = ydu/yduk % Нормирующий коэффициент для цифровой системы
%Останов
disp('Расчет полюсов для наблюдателя')
batterwort
pnd=exp(p*Ts)
l=place(SYS.A',SYS.C',pnd);
L=l'
%Останов
disp('Изменяем параметры объекта')
K01=4.95;
T11=0.33;
T21=0.06;
[a1,b1,c1,d1]=dlinmod('izm_block', Ts)
SYS1=ss(a1,b1,c1,d1,Ts)
step(SYS1,2.5)
%Расчет наблюдателя с использованием функции dreg
[An,Bn,Cn,Dn]=dreg(SYS.A,SYS.B,SYS.C,SYS.D,Kd,L)

