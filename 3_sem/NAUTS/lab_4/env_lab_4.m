clc, clear, close all
R = 2;
ke = 1;
km = 1;
J1 = 0.05;
J2 = 0.1;
L = 0.01;
p = 0.1;
A = [0 1/J2 0 0; -p 0 p 0; 0 -1/J1 0 km/J1; 0 0 -ke/L -R/L];
b = [0; 0; 0; 1/L];
P = [-5 -5 -5 -5];
c = [1 0 0 0];
disp("Коэффициенты обратной связи")
K = acker(A, b, P)
disp("Нормирующий коэффициент")
Kn = 1/(-c/(A-b*K)*b)

Q1 = diag([1 1 1 1]);
Q2 = diag([100 10 10 100]);
Q3 = diag([1000 1 1 1]);
Q = cat(3, Q1, Q2);
Q = cat(3, Q, Q3);
Am = A - b*K;
P = lyap(Am', Q1);
ga = diag([10 10 10 10]);
gb = 10;
Bm = b;

b0 = (b'*b)^-1 * b';
ka = b0*(Am-A)
kb = b0*(Bm-b)


%% 1 no control
adaptive = 0;
modal = 0;
Kn_init = Kn;
Kn = 1;
t = 60;
pulse_period = t*2;


result=sim('lab_4.slx');

figure
hold on
time = result.tout;
plot(time, result.system.Data)
xlabel("t, s")
ylabel("\omega_2, rad/s")
grid
hold off
Kn = Kn_init;

%% 2 modal control
adaptive = 0;
modal = 1;
t = 10;
pulse_period = t*2;
J2_init = J2;
p_init = p;

figure
hold on
for i = [[J2_init; p_init], [J2_init/3; p_init], [J2_init; p_init/3]]
    J2 = i(1);
    p = i(2);

    result=sim('lab_4.slx');
    time = result.tout;
    plot(time, result.system.Data)
end
legend( ...
    "Номинальные параметры", ...
    "J_2 = J_2/3", ...
    "p = p/3" ...
)
xlabel("time, s")
ylabel("\omega_2, rad/s")
grid
hold off

J2 = J2_init;
p = p_init;

%% 3 modal adaptive
adaptive = 1;
modal = 1;
t = 15;
pulse_period = t*2;
P_init = P;


J2_init = J2;
p_init = p;

for i = [[J2_init; p_init], [J2_init/3; p_init], [J2_init; p_init/3]]
    J2 = i(1);
    p = i(2);

    figure
    
    for j = 1:3
        q = Q(:,:,j);
        P = lyap(Am', q);
    
        result=sim('lab_4.slx');
        time = result.tout;
        hold on
        plot(time, result.system.Data)
    end
    grid
    xlabel("time, s")
    ylabel("\omega_2, rad/s")
    legend( ...
        "Q1 = diag([1 1 1 1]);", ...
        "Q2 = diag([100 10 10 100]);", ...
        "Q3 = diag([1000 1 1 1]);" ...
    )
end

J2 = J2_init;
p = p_init;
P = P_init;

%% 4 compare modal and adaptive-modal
P = lyap(Am', Q(:,:,3));
adaptive = 1;
t = 150;
pulse_period = 12;

J2_init = J2;
p_init = p;

J2 = J2_init;
p = p_init/3;

figure
hold on
grid
for i = [0 1]

    modal = i;
    result=sim('lab_4.slx');
    time = result.tout;
    if i == 1
        result.ga1.plot("b", DisplayName="with modal")
    else
        result.ga1.plot("r", DisplayName="w/o modal")
    end
end
ka = ka.*ones(size(time));
plot(time, ka(:,1),"--k", DisplayName="calculated")
legend

figure
hold on
grid
for i = [0 1]

    modal = i;
    result=sim('lab_4.slx');
    time = result.tout;
    if i == 1
        result.ga2.plot("b", DisplayName="with modal")
    else
        result.ga2.plot("r", DisplayName="w/o modal")
    end
end
ka = ka.*ones(size(time));
plot(time, ka(:,2),"--k", DisplayName="calculated")
legend

figure
hold on
grid
for i = [0 1]

    modal = i;
    result=sim('lab_4.slx');
    time = result.tout;
    if i == 1
        result.ga3.plot("b", DisplayName="with modal")
    else
        result.ga3.plot("r", DisplayName="w/o modal")
    end
end
ka = ka.*ones(size(time));
plot(time, ka(:,3),"--k", DisplayName="calculated")
legend

figure
hold on
grid
for i = [0 1]

    modal = i;
    result=sim('lab_4.slx');
    time = result.tout;
    if i == 1
        result.ga4.plot("b", DisplayName="with modal")
    else
        result.ga4.plot("r", DisplayName="w/o modal")
    end
end
ka = ka.*ones(size(time));
plot(time, ka(:,3),"--k", DisplayName="calculated")
legend


figure
hold on
grid
for i = [0 1]

    modal = i;
    result=sim('lab_4.slx');
    time = result.tout;
    hold on
    plot(time, result.gb.Data)
end

plot(time, kb.*ones(size(time)),"--k")
legend("w/o modal", "with modal", "calculated")

%% расчет Ka Kb

J2_init = J2;
p_init = p;
P = [-5 -5 -5 -5];

for i = [[J2_init; p_init], [J2_init/3; p_init], [J2_init; p_init/3]]
    J2 = i(1);
    p = i(2);

    A = [0 1/J2 0 0; -p 0 p 0; 0 -1/J1 0 km/J1; 0 0 -ke/L -R/L];
    K = acker(A, b, P);
    Am = A - b*K;
    Bm = b;
    b0 = (b'*b)^-1 * b';
    ka = b0*(Am-A)
    kb = b0*(Bm-b)
end

J2 = J2_init;
p = p_init;












