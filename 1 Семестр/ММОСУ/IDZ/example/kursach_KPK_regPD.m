clear; clc;
W0 = 23.0;% тонн
N0 = 800;% лс
vk0 = 9.0; %уз
v1max0 = 10.8; %уз
v2max0 = 26; %уз
%перевод в си
W = W0*1000;%кг
N = N0*735.5;% Вт
vk = vk0*0.51;% м/с начало глиссирования
v1max = v1max0*0.51;% м/с выход на крылья
v2max = v2max0*0.51;% м/с
Fmax = N/v2max;% N = F*v
dFmax = 0.2*Fmax;
dt = 1;
dPmax = dt*dFmax/Fmax*100;
dP = 0;
kp = 3;
kd = 15;
Vz = 7;% м/с
A1 = Fmax/v1max^2;
A2 = Fmax/v2max^2;
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
prev_e = Vz-v(1);
while(t(i) < 100)
    if (v(i)<vk)
        A = Fmax/v1max^2;
    end
    if ((v(i) >= vk)&& (v(i) <= v1max) )
        A = A1 - (v(i)-vk)*(A1-A2)/(v1max-vk);
    end
    if (v(i) > v1max)
        A = A2;
    end
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
    i = i + 1;
    dx = x(i)-x(i-1);      
end
figure(3)
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