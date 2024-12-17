clc, clear, close all

%% envs
a1 = 5; % 5
a2 = 1; % 1
a1_o = 5; % 5 observer parameters
a2_o = 1; % 1 observer parameters

A = [0 a1; -a2 -a2];

b = [0; a2];
c = [1 0];

p = [-4.5 -4.5];
K = acker(A,b,p)
kn = 1 / (-c/(A-b*K)*b);
po = p*5; 
L=acker(A',c',po)
x1_0 = 0;
x2_0 = 0;

%% w/o control
direct = 1;
observer = 0;
t = 15;
result=sim('lab_3.slx');

figure
hold on
time = result.out.Time;
plot(time, result.out.Data)
xlabel("time, s")
grid
hold off

%% modal control
direct = 0;
observer = 0;
t = 2.5;

figure
hold on
for i = [[5; 1], [5*3; 1], [5; 1/3]]
    a1 = i(1);
    a2 = i(2);

    result=sim('lab_3.slx');
    time = result.out.Time;
    plot(time, result.out.Data)
end
legend( ...
    "a_1 = 5; a_2 = 1", ...
    "a_1 = 15; a_2 = 1", ...
    "a_1 = 5; a_2 = 1/3" ...
)
xlabel("time, s")
grid
hold off

%% modal control with observer
direct = 0;
observer = 1;
t = 2.5;

figure
for i = [[5; 1], [5*3; 1], [5; 1/3]]
    a1 = i(1);
    a2 = i(2);

    result=sim('lab_3.slx');
    time = result.out.Time;

    subplot(2,1,1);
    hold on
    plot(time, result.out.Data)

    subplot(2,1,2);
    hold on
    plot(time, result.observer_error.Data)
end
subplot(2,1,1);
legend( ...
    "a_1 = 5; a_2 = 1", ...
    "a_1 = 15; a_2 = 1", ...
    "a_1 = 5; a_2 = 1/3" ...
)
xlabel("time, s")
grid
title('График x_1')

subplot(2,1,2);
legend( ...
    "a_1 = 5; a_2 = 1", ...
    "a_1 = 15; a_2 = 1", ...
    "a_1 = 5; a_2 = 1/3" ...
)
xlabel("time, s")
grid
title('График ошибки наблюдателя')
hold off

%% changes in initial condition
direct = 0;
observer = 1;
t = 2.5;
a1 = 5;
a2 = 1;

figure

for i = [-0.5 0 0.5]
    x1_0 = i;
    x2_0 = i;

    result=sim('lab_3.slx');
    time = result.out.Time;
    subplot(2,1,1);
    hold on
    plot(time, result.out.Data)

    subplot(2,1,2);
    hold on
    plot(time, result.observer_error.Data)
end

subplot(2,1,1);
legend( ...
    "x_1(0) = x_2(0) = -0.5", ...
    "x_1(0) = x_2(0) = 0", ...
    "x_1(0) = x_2(0) = 0.5" ...
)
xlabel("time, s")
grid
title('График x_1')

subplot(2,1,2);
legend( ...
    "x_1(0) = x_2(0) = -0.5", ...
    "x_1(0) = x_2(0) = 0", ...
    "x_1(0) = x_2(0) = 0.5" ...
)
xlabel("time, s")
grid
title('График ошибки наблюдателя')

hold off



