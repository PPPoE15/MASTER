function [t,x] = Rossler(a,b,c,x0,tmax)
% x - x(1), y - x(2), z - x(3)
% x0 = [1; 1; 0];    ��������� �������
% a = 0.2; b = 0.2; c = 5.7;
% dt = ��� �� t
% tmax = ����� �������������
% k = ���������� �������
% x = ������� 
% FP = ������ �����
% Order = 1 ����� ������, 4 ��� RK4 � 5 ��� RK5
Order = 4;                 % ��������� ������
tic;
f = @(t,x) [-x(2)-x(3); x(1)+a*x(2); b+x(3)*(x(1)-c)];  % ������� ��������
k = 5000;       % k+1 ����� ��������� � ������� �������
dt = 0.1; time = 0; 
p = 0;
%tmax = 20; 
x(:, 1) = x0 (:, 1); t(1) = 0;
while (time<tmax)
    n = 2^p;
    h = dt/n;
    t0 = 0;
    x0 = [1; 1; 0];
    C = clock;
    for j = 1:n*k
        if Order == 1
            x0 = EULER(f,h,t0,x0);         % ����� ������ ������ EULER()
        else if Order == 4
                x0 = RK4(f,h,t0,x0);       % ����� ������ RK4()
            else x0 = RK5(f,h,t0,x0);      % ����� ������ RK5()
            end
        end
        t0 = j*h;
            x(:,j+1) = x0;            
            t(j+1) = t0;             
    end
    time = etime(clock,C);
    p = p + 1;
end
end