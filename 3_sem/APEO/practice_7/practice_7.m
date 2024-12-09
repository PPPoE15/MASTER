clear, clc, close all
A = 10;
B = 10;
H = 5;
Lp = [82 88 95 90 91 98 81 73];
a = [.1 .2 .7 .8 .7 .8 .75 .78];

w = [63 125 250 500 1000 2000 4000 8000];
B_p = [17 19 23 29 36 50 65 100];

V = A*B*H;
S = 2*(A*B + B*H + A*H);
an = B_p ./ (B_p+S);

figure
hold on
set(gca, 'XScale', 'log')
plot(w,Lp)

for k = [1 0.5 0.1]

    S0 = k*S;
    G = S.*an - S0.*(an-a);
    B_pa = (S.*G) / (S-G);
    
    dL = 10*log10(B_pa./B_p);
    L = Lp - dL;
    

    plot(w,L)

end

grid on
legend( ...
    "L_p", ...
    "L_r (S_0=S)", ...
    "L_r (S_0=0.5S)", ...
    "L_r (S_0=0.1S)" ...
)
xlabel("\omega, Hz")
ylabel("L, dB")

%% compare
S0 = 0.5*S;


a1=[0.16 0.18 0.26 0.50 0.60 0.80 0.80 0.80];
a2=[0.15 0.15 0.25 0.50 0.65 0.80 0.82 0.92];
a3=[0.15 0.28 0.50 0.50 0.70 0.70 0.70 0.65];
a4=[0.10 0.12 0.35 0.40 0.82 0.90 0.92 0.88];

a5=[0.20 0.30 0.45 0.65 0.87 0.80 0.95 0.80];
a6=[0.15 0.20 0.40 0.60 0.73 0.75 0.75 0.80];
a7=[0.20 0.43 0.60 0.95 0.87 0.80 0.86 0.95];
a8=[0.15 0.20 0.52 0.67 0.85 0.88 0.85 0.90];

A = [a1; a2; a3; a4; a5; a6; a7; a8];
figure


for i = 1:4
    figure(i+1)
    hold on
    set(gca, 'XScale', 'log')
    plot(w,Lp)
    for k = 1:2
        if k == 1
            a = A(i,:);
        else
            a = A(i+4,:);
        end
        G = S.*an - S0.*(an-a);
        B_pa = (S.*G) / (S-G);
        dL = 10*log10(B_pa./B_p);
        L = Lp - dL;
        plot(w,L)
    end
    grid on
    legend( ...
        "L_p", ...
        "L_r Не отнесенные от стенки", ...
        "L_r Отнесенные от стенки" ...
    )
    xlabel("\omega, Hz")
    ylabel("L, dB")

end




