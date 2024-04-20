%% Initial data
clc, clear, close all
x=(-1:.1:3)';
y=humps(x);

%% anfis model
trnData = [x y];
numMFs = 30;
epoch_n = 60;
in_fismat = genfis1(trnData, numMFs,'gauss2mf', 'linear');
out_fismat = anfis(trnData, in_fismat, epoch_n);
z1 = evalfis(out_fismat, x);
% ruleview(out_fismat)

%% genfis2 model
Xin = x;
Xout = y;
fismat = genfis2(Xin, Xout, 0.01);
z2 = evalfis(fismat, x);
% ruleview(fismat)

%% plot result
figure(1)
hold on
plot(x,y, '--', 'LineWidth', 2)
plot(x,z1)
plot(x,z2)
grid on
legend('Training Data','ANFIS Output','GENFIS2 Output');
rmse1 = sqrt(mean((y - z1).^2))
rmse2 = sqrt(mean((y - z2).^2))


%% experiment
x=(-1:.005:3)';
y=humps(x);
z1 = evalfis(out_fismat, x);
z2 = evalfis(fismat, x);
figure(2)
hold on
plot(x,y, '--', 'LineWidth', 2)
plot(x,z1)
plot(x,z2)
grid on
legend('Training Data','ANFIS Output','GENFIS2 Output');