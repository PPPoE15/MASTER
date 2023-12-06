clear; clc;
%Регулятор НВК Малый рабочий катер
W0 = 4.6;% тонн
N0 = 50;% лс
v0 = 9.0; %уз
%перевод в си
W = W0*1000;%кг
N = N0*735.5;% Вт
vmax = v0*0.51;% м/с
Fmax = N/vmax;% N = F*v
A = Fmax/vmax^2;
dFmax = 0.2*Fmax;
dt = 0.5;
dPmax = dt*dFmax/Fmax*100;
kp = 7;
kd = 25;
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
Vz = 3;% м/с
prev_e = Vz-v(1);
while(t(i) < 50)
    tt = t(i)+dt;
    t = [t tt];
    xx = x(i)+dx+(P(i)*Fmax*dt^2/100-A*dx*abs(dx))/W;
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
figure(2)
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