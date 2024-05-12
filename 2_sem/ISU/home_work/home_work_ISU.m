clear, clc
W1 = [1 -1 -3;
      2 -1 -1];
W2 = [0.5 4 -2];
u = 0.8;
gamma = 0.6;
r = [1 0.6 0.5]';
i = 1;
e = 0.0001;
while(1)
    s1 = W1*r;
    q1 = activate(s1);
    s2 = W2*[1; q1];
    q2 = activate(s2);
    
    if(abs(q2 - u) < e)
        break
    end
    i = i+1;
    del2 = (u-q2)*q2*(1-q2);

%     z1 = W2(2:end) .* del2;
%     q11 = q1(1);
%     q12 = q1(2);
%     del11 = q11*(1 - q11)*z1(1);
%     del12 = q12*(1 - q12)*z1(2);
    
    dW2 = [1;q1]*(gamma*del2);
    W2 = W2+dW2';
end

disp(q2)
disp(i)


