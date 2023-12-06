clear, clc, close all
%НВК Парижская Коммуна
W0 = 314;% тонн
N0 = 480;% лс
v0 = 8.5; %уз
%перевод в си
W = W0*1000;%кг
N = N0*735.5;% Вт
vmax = v0*0.51;% м/с
Fmax = N/vmax;% N = F*v
A = Fmax/vmax^2;
dFmax = 0.1*Fmax;
dt = 5;
dPmax = dt*dFmax/Fmax*100;
dP = 10;
if (dP >= dPmax)
    dP = dPmax;
end
Pmax = 100; % максимальная тяга
i = 1;
t = [0];
v = [0];
P = [0];
x = [0];
dx = 0;
eps = 0.007;% допустимая погрешность, т.к. идеально не попадем
%разгон
while ( (vmax-v(i)) > eps)
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
% торможение
while ( v(i) > eps)
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
NVK_Paris = [t' P' x' v'];% для таблицы
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