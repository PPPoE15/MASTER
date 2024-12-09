clear, clc, close all
% steel
Rs2=[16 20 24 28 32 35 39 39]; % 2
Rs3=[19 23 27 31 35 37 36 39]; % 3
Rs5=[23 27 31 35 37 32 39 43]; % 5
Rs10=[27 30 35 37 37 39 43 47]; % 10
% glass
Rg3=[14 18 22 26 30 32 30 36];
Rg4=[16 20 24 28 30 32 30 36];
Rg6=[21 25 27 30 32 30 36 40];
% wood
Rw4=[6 10 14 18 22 26 28 25];
Rw8=[14 18 21 24 27 25 28 32];

w = [63 125 250 500 1000 2000 4000 8000];

V = 480;
S0 = 32;
B_p = [17 19 23 29 36 50 65 100];

Lp = [76 81 75 71 68 66 60 54];
Ln = [71 61 54 49 45 42 40 38];
Rt = Lp - Ln - 10*log10(B_p) + 10*log10(S0);
Rt(5)



figure
hold on
set(gca, 'XScale', 'log')
plot(w,Lp)
plot(w,Ln)
plot(w,Lp - Rs2 - 10*log10(B_p) + 10*log10(S0))
plot(w,Lp - Rs3 - 10*log10(B_p) + 10*log10(S0))
plot(w,Lp - Rs5 - 10*log10(B_p) + 10*log10(S0))
plot(w,Lp - Rs10 - 10*log10(B_p) + 10*log10(S0))
grid on
legend( ...
    "L_p", ...
    "L_n", ...
    "L_r steel 2mm", ...
    "L_r steel 3mm", ...
    "L_r steel 5mm", ...
    "L_r steel 10mm" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")

figure
hold on
set(gca, 'XScale', 'log')
plot(w,Lp)
plot(w,Ln)
plot(w,Lp - Rg3 - 10*log10(B_p) + 10*log10(S0))
plot(w,Lp - Rg4 - 10*log10(B_p) + 10*log10(S0))
plot(w,Lp - Rg6 - 10*log10(B_p) + 10*log10(S0))
grid on
legend( ...
    "L_p", ...
    "L_n", ...
    "L_r glass 3mm", ...
    "L_r glass 4mm", ...
    "L_r glass 6mm" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")

figure
hold on
set(gca, 'XScale', 'log')
plot(w,Lp)
plot(w,Ln)
plot(w,Lp - Rw4 - 10*log10(B_p) + 10*log10(S0))
plot(w,Lp - Rw8 - 10*log10(B_p) + 10*log10(S0))
grid on
legend( ...
    "L_p", ...
    "L_n", ...
    "L_r wood 4mm", ...
    "L_r wood 8mm" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")




figure
hold on
set(gca, 'XScale', 'log')
plot(w,Rt)
plot(w,Rs2)
plot(w,Rs3)
plot(w,Rs5)
plot(w,Rs10)
grid on
legend( ...
    "R_t", ...
    "R_0 steel 2mm", ...
    "R_0 steel 3mm", ...
    "R_0 steel 5mm", ...
    "R_0 steel 10mm" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")

figure
hold on
set(gca, 'XScale', 'log')
plot(w,Rt)
plot(w,Rg3)
plot(w,Rg4)
plot(w,Rg6)
grid on
legend( ...
    "R_t", ...
    "R_0 glass 3mm", ...
    "R_0 glass 4mm", ...
    "R_0 glass 6mm" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")

figure
hold on
set(gca, 'XScale', 'log')
plot(w,Rt)
plot(w,Rw4)
plot(w,Rw8)
grid on
legend( ...
    "R_t", ...
    "R_0 wood 4mm", ...
    "R_0 wood 8mm" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")
