clc, clear, close all
%% env
t = 10;
pulse = 0;
adapt_control=0;

am1 = -10;
am2 = -16;
Am = [0 1; am1 am2];
bm = 16;
Bm = [0;bm];

a1 = 2; % stable -2; unstable 2
a2 = 4; % stable -4; unstable 4
A = [0 1; a1 a2];
b = 1;
B = [0;b];

au1 = 2;
au2 = 4;
bu = 1;

P = [2 1; 1 1];
ga = [1 0; 0 1];
gb = 1;

b0 = (b'*b)^-1 * b';
ka = b0*(Am-A);
kb = b0*(Bm-B);

%% compare
result=sim('lab_2.slx');

figure(1)
hold on
time = result.stable.Time;
plot(time, result.stable.Data, DisplayName="stable system")
plot(time, result.model.Data, DisplayName="model")
plot(time, result.unstable.Data, DisplayName="unstable system")
ylim([0 2])
xlabel("t, s")
grid
legend
hold off

%% adaptive control
adapt_control=1;
for k = [1 10 10]
    ga = ga.*k;
    gb = gb*k;

    result=sim('lab_2.slx');

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
ylim([0 2])
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

result=sim('lab_2.slx');
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

result=sim('lab_2.slx');
figure(4)
hold on
time = result.stable.Time;
plot(time, result.stable.Data)
plot(time, result.model.Data)
grid
legend("system", "model")



