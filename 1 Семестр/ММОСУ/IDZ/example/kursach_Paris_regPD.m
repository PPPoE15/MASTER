clear; clc;
%регулятор НВК Париж
W0 = 30395;% тонн
N0 = 61000;% лс
v0 = 21.5; %уз
%перевод в си
W = W0*1000;%кг
N = N0*735.5;% Вт
vmax = v0*0.51;% м/с
Fmax = N/vmax;% N = F*v
dFmax = 0.1*Fmax;
dt = 10;
dPmax = dt*dFmax/Fmax*100;
dP = 0;
if (dP >= dPmax)
    dP = dPmax;
end
Vz = 8;% задание м/с
kp = 5;% коэффициент ПД регулятора
kd = 150;% коэф ПД регулятора
A = Fmax/vmax^2;
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
prev_e = Vz-v(1);
while(t(i) < 600)
    t = [t t(i)+dt];
    xx = x(i)+dx+((P(i)*Fmax*dt^2)/100-A*dx*abs(dx))/W;
    x = [x xx];
    vv = (x(i+1)-x(i))/dt;
    v = [v vv];
    e = Vz - v(i);
    de = (e-prev_e)/dt;
    dP = kp*e+kd*de;
    prev_e = e;
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
figure(1)
subplot(3,1,1)
plot(t,x,'Linewidth',1.5); grid on; 
xlabel('t, c','FontSize',12,'FontWeight','bold'); 
ylabel('x, м','FontSize',12,'FontWeight','bold');
subplot(3,1,2)
plot(t,v,'Linewidth',1.5);grid on; 
xlabel('t, c','FontSize',12,'FontWeight','bold'); 
ylabel('v, м/с','FontSize',12,'FontWeight','bold');
subplot(3,1,3)
plot(t,P,'Linewidth',1.5);grid on; 
xlabel('t, c','FontSize',12,'FontWeight','bold'); 
ylabel('P,%','FontSize',12,'FontWeight','bold');