clc, clear, close all
a = [0 0.1 0.2 0.3 0.35 0.8];
b = [0.1 0.5 1 1.5 2 2.5];
c = [0.5 2 2.7 4 4.5 6 8.5 8.7 9 12 13 18];
x0 = [1; 1; 0];
tmax = 10;

Attractor(0.3, 0.2, 5.7, x0, tmax)
% for i = 1:size(a,2)
%     Attractor(a(i), 0.2, 5.7, x0, tmax)
%     close all
% end
% 
% for i = 1:size(b,2)
%     Attractor(0.2, b(i), 5.7, x0, tmax)
%     close all
% end
% 
% for i = 1:size(c,2)
%     Attractor(0.2, 0.2, c(i), x0, tmax)
%     close all
% end
