clear, clc, close all

W0 = 4.6;% тонн
N0 = 235;% лс
v0 = 19.5; %уз

W = W0*1000;%кг
N = N0*735.5;% Вт
Vmax = v0*0.51;% м/с
Fmax = N/Vmax;% N = F*v
A = Fmax/Vmax^2;
dFmax = 0.2*Fmax;
dt = 0.5;

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
e = 0.005; % допустимая погрешность

% разгон
while ( (Vmax-v(i)) > e)
    t = [t t(i)+dt];
    x = [x x(i)+dx+(P(i)*Fmax*dt^2/100-A*dx*abs(dx))/W];
    v = [v (x(i+1)-x(i))/dt];
    if (P(i) < Pmax && (P(i)+dP) <= 100)
        P = [P (P(i)+dP)];
    else
        P = [P Pmax];
    end
    i = i + 1;
    dx = x(i)-x(i-1); 
    if ((v(i)-v(i-1))<e/10 && i > 3) %учитывает, что мощность может быть не 100%
        break
    end
end

% торможение
while ( v(i) > e)
    tt = t(i)+dt;
    t = [t tt];
    tx = x(i)+dx+(P(i)*Fmax*dt^2/100-A*dx*abs(dx))/W;
    x = [x tx];
    tv = (x(i+1)-x(i))/dt;
    v = [v tv];
    if (P(i) > -Pmax)
        P = [P (P(i)-dP)];
    else
        P = [P -Pmax];
    end
    i = i + 1;
    dx = x(i)-x(i-1);    
end
NVK_aist = [t' P' x' v']; % составление таблицы
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
ylabel('P,%','FontSize', 12);
