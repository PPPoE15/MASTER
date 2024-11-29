clc, clear, close all

% %% env task 1
% 
% P = [2 1; 1 1];
% B = [2 0; 0 1];
% A = [0 1; -1 -3];
% C = eye(2);
% Gamma = 10;
% u = 1;
% D = [];


%% env task 2
t = 10;
pulse = 0;
adapt_control=0;

a1 = -4;
a2 = -1.6;
A = [0 1; a1 a2];
b = 8;
B = [0;b];

am1 = -100/9; % stable -2; unstable 2
am2 = -50/9; % stable -4; unstable 4
Am = [0 1; am1 am2];
bm = 300/9;
Bm = [0;bm];

P = [1.34 0.045; 0.045 0.0981];
ga = [1 0; 0 1];
gb = 1;

b0 = (b'*b)^-1 * b';
ka = b0*(Am-A);
kb = b0*(Bm-B);

%% compare
result=sim('task_2.slx');

figure(1)
hold on
time = result.stable.Time;
plot(time, result.stable.Data, DisplayName="stable system")
plot(time, result.model.Data, DisplayName="model")
% ylim([0 2])
xlabel("t, s")
grid
legend
hold off

%% adaptive control
adapt_control=1;
for k = [1 10 10]
    ga = ga.*k;
    gb = gb*k;

    result=sim('task_2.slx');

    figure(2)
    hold on
    plot(result.stable.Time, result.stable.Data)
end

plot(result.stable.Time, result.model.Data)
legend( ...
    "g_a_1 = g_a_2 = g_b = 1", ...
    "g_a_1 = g_a_2 = g_b = 10", ...
    "g_a_1 = g_a_2 = g_b = 100", ...
    "model" ...
)
% ylim([0 2])
hold off
grid
xlabel("t, s")

%% ka kb
adapt_control=1;
ga = [1 0; 0 1];
gb = 1;
ga = ga.*100;
gb = gb*100;
t = 40;
pulse = 1;

result=sim('task_2.slx');
figure(3)
hold on
time = result.stable.Time;
plot(time, result.ka1.Data(1,:))
plot(time, ka(2,1)*ones(size(time)))

plot(time, result.ka2.Data(1,:))
plot(time, ka(2,2)*ones(size(time)))

plot(time, result.kb.Data)
plot(time, kb(2,1)*ones(size(time)))
grid
% ylim([-25 20])
xlabel("t, s")
legend( ...
    "k_a_1 measured", ...
    "k_a_1 calculated", ...
    "k_a_2 measured", ...
    "k_a_2 calculated", ...
    "k_b measured", ...
    "k_b calculated" ...
)


%% meandr
pulse = 1;
adapt_control = 1;

result=sim('task_2.slx');
figure(4)
hold on
time = result.stable.Time;
plot(time, result.stable.Data)
plot(time, result.model.Data)
grid
legend("system", "model")





