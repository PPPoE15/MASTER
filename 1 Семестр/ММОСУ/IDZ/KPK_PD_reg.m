clear, clc, close all
%КПК
W0 = 50; % тонн
N0 = 3500 ;% лс
vk0 = 16; %уз
v1max0 = 19.2; %уз
v2max0 = 46; %уз
%перевод в си
W = W0*1000; %кг
N = N0*735.5; % Вт
vk = vk0*0.51 % м/с начало глиссирования
v1max = v1max0*0.51 % м/с выход на крылья
v2max = v2max0*0.51 % м/с
Fmax = N/v2max; % N = F*v
dFmax = 0.15*Fmax;
dt = 0.5;
dPmax = dt*dFmax/Fmax*100;
Pmax = 100; % максимальная тяга
dP = 15;
if (dP >= dPmax)
    dP = dPmax;
end
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;

Vz = 8; % задание м/с
kp = 3; % коэффициент ПД регулятора
kd = 5; % коэф ПД регулятора

prev_e = Vz - v(1);

%разгон
A1 = Fmax/v1max^2;
A2 = Fmax/v2max^2;
while(t(i) < 30)
    if (v(i)<vk)
        A = Fmax/v1max^2;
    end
    if ((v(i) >= vk)&& (v(i) <= v1max) )
        A = A1 - (v(i)-vk)*(A1-A2)/(v1max-vk);
    end
    if (v(i) > v1max)
        A = A2;
    end
    t = [t t(i) + dt];
    x = [x x(i) + dx + (P(i)*Fmax*dt^2/100 - A*dx*abs(dx))/W];
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
    if (P(i)+dP <= 100)
        P = [P P(i)+dP];
    end  
    i = i + 1;
    dx = x(i)-x(i-1);      
end


figure(3)
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
