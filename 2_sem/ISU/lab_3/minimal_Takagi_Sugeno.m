%% Initial data
clc, clear, close all
x=(-1:.005:3)';
y=humps(x);
figure(1)
plot(x,y, '--', 'LineWidth', 2)
grid on
hold on

%% anfis model
trnData = [x y];
numMFs = 5;
inmfType = 'trimf';
outmfType = 'linear';
epoch_n = 20;
in_fismat = genfis1(trnData,numMFs,inmfType, outmfType);
out_fismat = anfis(trnData,in_fismat,epoch_n);
z1 = evalfis(out_fismat, x);
plot(x,z1);

legend('Training Data',"out 5 MFs");