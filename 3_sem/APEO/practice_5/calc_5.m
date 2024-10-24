clear, clc, close all
M = 2.03; %H  м; 
w = 2*pi*100; %  linspace(0, 2*pi*300, 100)
P = 20128; % Н * м^2; 
h = 0.018;
l = 0.08; % linspace(0.01,1,100)
Rc = 0.07;
Mst = 40; %linspace(20,80,100)
E = 2e11; 
Rin = 0.05;
V = 0.0025; % pi*Rout^2*l
Rout = 0.1; % sqrt(V./l./pi)
Cz = 0.65e6; 
Cy = 0.35e6; 
Ra = 0.2; 
n = 4;
r = 4;
r2 = r^2;
Rr = 0;

J = 0.5.*Mst.*(Rin.^2+Rout.^2);
Ca = n.*Cz;
Ct = Ca.*Rout.^2;
Kt = 0.1.*sqrt(Ct.*J);
gamma = M ./ sqrt((Ct - J.*w.^2).^2 + (Kt.*w).^2);
Zm = 0.5.*Ra.*gamma
Lm = 20.*log10((Zm.*w.^2)./(sqrt(2).*3e-4))

Cr = r2.*(r2-1).^2 ./ (r2+1) .* 2.*pi.*E.*l.*h.^3 ./ (12.*Rc.^3);
Ps = 2.*pi.*Rin.*l.*P;
Zp = Ps ./ sqrt((Cr-Mst.*w.^2).^2 + (Rr.*w).^2)
Lp = 20.*log10((Zp.*w.^2) ./ (sqrt(2).*3e-4))


figure(1)
plot(Mst, Lm)
xlabel("M_s_t, kg")
ylabel("L_m, dB")
grid on

figure(2)
plot(Mst, Lp)
ylim([23.75,24])
xlabel("M_s_t, kg")
ylabel("L_p, dB")
grid on

figure(3)
plot(l, Lm)
xlabel("l, m")
ylabel("L_m, dB")
grid on

figure(4)
plot(l, Lp)
xlabel("l, m")
ylabel("L_p, dB")
grid on