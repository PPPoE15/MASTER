% Аппроксимация функции
x = -1:.05:2;  % задание входного вектора;
y = humps(x);% задание выходного вектора;
P = x; T = y;
% Создание и тестирование нейронной сети
net = newff([-1 2],[20, 1],{'tansig','purelin'},'trainlm');
% newff– сеть прямого распространения(feedforward);
% [–1 2] – матрица минимальных и максимальных значений входных элементов;
% [5, 1] – матрица, указывающая на число ИН в слоях: 5 – число ИН в первом скрытом слое, 1– число ИН в выходном слое;
%{'tansig','purelin'}
% 'tansig'– функция активации скрытого слоя(гиперболический тангенс).
% Варианты: tansig;  hardlim; logsig; hardlims; satlin; tribas;
%'purelin'– линейная функция активации выходного слоя;
%'traingd'– алгоритм обучения обратного распространения ошибки;
% Варианты: 'trainbr'; 'trainlm';
net.trainParam.show = 400;    % результаты выводить через 400 итераций; 
net.trainParam.lr = 0.05;     % скорость обучения;
net.trainParam.epochs = 1000; % количество циклов обучения;
net.trainParam.goal = 1e-3;   % заданная ошибка обучения;
% Обучение сети
net1 = train(net, P, T);
% Тестирование сети
a=sim(net1,P);
% Создание графиков исходного и аппроксимированного сигнала 
plot(P,a,'r-'); grid; hold;
xlabel('time(s)'); ylabel('output'); title('humps function')
plot(P,T,'k*')
legend('approximation data', 'training data')
% gensim(net1)

%% RBF
% Аппроксимация функции
x = -1:.05:2;  % задание входного вектора;
y=humps(x);% задание выходного вектора;
P=x; T=y;
% Создание и тестирование нейронной сети с радиальными базисными элементами
goal = 0.02;  % среднеквадратичная ошибка;
spread=0.5; %  разброс параметров;
net = newrb(P,T,goal,spread);
%Тестирование сети
a=sim(net,P);
% Создание графиков исходного и аппроксимированного сигнала 
figg = figure(1);
plot(P,a,'r-'); grid; hold;
plot(P,T,'k*'); xlabel('Time(s)'); ylabel('Output of network and error');
title ('Humps function approximation – radial basis function')
% gensim(net) % создание модели сети в Toolbox Simulink

