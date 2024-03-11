function [ roots_req, b ] = GetPolyRoots(n,t_req,acc_req,poly_type )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

switch(poly_type)
    case 1 % ������� �������
        z = [];
        k = 1;
        p = ones(1,n)*(-1);
    case 2 % ������� �����������
        [z,p,k]=buttap(n);
    case 3 % ������� �������
        [z,p,k]=besselap(n);
    otherwise
        error('������� ����� ��� ��������');
end
[b,a]=zp2tf(z,p,k);
SYS=tf(b,a);
[Y,T]=step(SYS,0:0.01:20);
T_dyn = T(Y>1+acc_req | Y < 1-acc_req );
t_end = T_dyn(end);
w0 = t_end/t_req;
for i=1:n     % ������ ������������� ��������� ��������
    a(i+1)=a(i+1).*w0^(i);	
end
b=a(n+1);     % ������ ��������������� ������������ � ������ ����
if (poly_type == 1)
    roots_req(1:n) = - w0;
    roots_req = roots_req';
else
   roots_req = roots(a); 
end
end

