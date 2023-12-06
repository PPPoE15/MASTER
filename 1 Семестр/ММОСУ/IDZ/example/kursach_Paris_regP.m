clear; clc;
W0 = 30395;% тонн
N0 = 61000;% лс
v0 = 21.5; %уз
%перевод в си
W = W0*1000;%кг
N = N0*735.5;% Вт
vmax = v0*0.51;% м/с
Fmax = N/vmax;% N = F*v
A = Fmax/vmax^2;
dFmax = 0.1*Fmax;
dt = 10;
dPmax = dt*dFmax/Fmax*100;
dP = 0;
if (dP >= dPmax)
    dP = dPmax;
end
Vz = 9;% задание м/с
kp = 5;% коэффициент П регулятора
A = Fmax/vmax^2;
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
while(t(i) < 600)
    t = [t t(i)+dt];
    xx = x(i)+dx+((P(i)*Fmax*dt^2)/100-A*dx*abs(dx))/W;
    x = [x xx];
    vv = (x(i+1)-x(i))/dt;
    v = [v vv];
    e = Vz - v(i+1);
    dP = kp*e;
    if (abs(dP) >= dPmax)
    dP = dPmax;
    end
    if (P(i)+dP > 100)
        P = [P 100];
    end
    if (P(i)+dP <= 100)
        P = [P P(i)+dP];
    end
    i = i+1;
    dx = x(i)-x(i-1);
end
 plot(t,v)