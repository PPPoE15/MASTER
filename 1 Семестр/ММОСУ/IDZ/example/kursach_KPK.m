clear; clc;
%КПК
W0 = 23.0;% тонн
N0 = 800;% лс
vk0 = 9.0; %уз
v1max0 = 10.8; %уз
v2max0 = 26; %уз
%перевод в си
W = W0*1000;%кг
N = N0*735.5;% Вт
vk = vk0*0.51% м/с начало глиссирования
v1max = v1max0*0.51% м/с выход на крылья
v2max = v2max0*0.51% м/с
Fmax = N/v2max;% N = F*v
dFmax = 0.2*Fmax;
dt = 1;
dPmax = dt*dFmax/Fmax*100;
Pmax = 100; % максимальная тяга
dP = 10;
if (dP >= dPmax)
    dP = dPmax;
end
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
eps = 0.007;% допустимая погрешность, т.к. идеально не попадем
%разгон
A1 = Fmax/v1max^2;
A2 = Fmax/v2max^2;
while ( (v2max-v(i)) > eps)
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
    if (P(i) < Pmax)
        P = [P (P(i)+dP)];
    else
        P = [P Pmax];
    end
    i = i + 1;
    dx = x(i)-x(i-1);
    if ((v(i)-v(i-1))<eps/10 && i > 3) %учитывает, что мощность может быть не 100%
        break
    end
end
%торможение
while ( v(i) > eps)
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
    if (P(i) > -Pmax)
        P = [P (P(i)-dP)];
    else
        P = [P -Pmax];
    end
    i = i + 1;
    dx = x(i)-x(i-1);    
end
KPK = [t' P' x' v'];% для таблицы
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