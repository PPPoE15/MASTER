clear, clc, close all

W0 = 314; % тонн
N0 = 480; % лс
v0 = 8.5; %уз

W = W0*1000; %кг
N = N0*735.5; % Вт
Vmax = v0*0.51; % м/с
Fmax = N/Vmax; % N = F*v
A = Fmax/Vmax^2;
dFmax = 0.2*Fmax;
dt = 1;
dPmax = dt*dFmax/Fmax*100;
dP = 20;
if (dP >= dPmax)
    dP = dPmax;
end

% Н.У.
Pmax = 100; % максимальная тяга
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
eps = 0.005; % допустимая погрешность

Vz = 2; % задание м/с
kp = 10; % коэффициент ПД регулятора
kd = 80; % коэф ПД регулятора

prev_e = Vz - v(1);

while(t(i) < 100)
    t = [t t(i) + dt];
    x = [x x(i) + dx + ((P(i)*Fmax*dt^2)/100 - A*dx*abs(dx))/W];
    v = [v (x(i+1) - x(i))/dt];
    e = Vz - v(i);
    de = (e - prev_e)/dt;
    dP = kp*e + kd*de;
    prev_e = e;
    if (abs(dP) >= dPmax)
    dP = dPmax;
    end
    if (P(i) + dP > 100)
        P = [P 100];
    end
    if (P(i) + dP <= 100)
        P = [P P(i) + dP];
    end
    i = i + 1;
    dx = x(i) - x(i-1);
end
figure(1)
subplot(3,1,1)
plot(t,x,'Linewidth',1.5); grid on; 
xlabel('t, c','FontSize',12); 
ylabel('x, м','FontSize',12);
subplot(3,1,2)
plot(t,v,'Linewidth',1.5);grid on; 
xlabel('t, c','FontSize',12); 
ylabel('v, м/с','FontSize',12);
subplot(3,1,3)
plot(t,P,'Linewidth',1.5);grid on; 
xlabel('t, c','FontSize',12); 
ylabel('P,%','FontSize',12);

