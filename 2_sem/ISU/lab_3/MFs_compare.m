%% Initial data
clc, clear, close all
x=(-1:.005:3)';
y=humps(x);
figure(1)
plot(x,y, '--', 'LineWidth', 2)
grid on
hold on

%% anfis model
MFs = ["gbellmf" "gauss2mf" "gaussmf" "pimf" "trapmf" "trimf"];
outmfTypes = ["constant" "linear"];
trnData = [x y];
numMFs = 10;
inmfType = 'gauss2mf';
outmfType = 'linear';
epoch_n = 20;
% in_fismat = genfis1(trnData,numMFs,inmfType, outmfType);
% out_fismat = anfis(trnData,in_fismat,epoch_n);
% z1 = evalfis(out_fismat, x);
% out = evalfis(out_fismat, 2);
in_fismat = genfis1(trnData,numMFs,inmfType, outmfType);
for i = 5:5:30
    epoch_n = i;
    
    out_fismat = anfis(trnData,in_fismat,epoch_n);
    z1 = evalfis(out_fismat, x);
    plot(x,z1);
end

legend('Training Data',"5","10", "15", '20',"25", "30");


%% genfis2 model
Xin = x;
Xout = y;
% fismat = genfis2(Xin,Xout,0.01);
% z2 = evalfis(x, fismat);
for i = linspace(0.01, 0.75, 5)
    fismat = genfis2(Xin,Xout,i);
    z2 = evalfis(x, fismat);
    plot(x,z2);
end

legend('Training Data',"0.0100","0.1950", "0.3800", '0.5650',"0.7500");