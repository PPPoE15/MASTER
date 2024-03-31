close all, clear
figure (1)
hold on

for i=400:-100:100
    V = i;
    sim('scheme_3.slx');
    plot(ans.torque_400(10001:end), ans.speed_400(10001:end))
end
ylim([0 160])
xlim([0 140])
legend('400 В', '300 В', '200 В', '100 В')
grid on
ylabel('Speed, rad/s')
xlabel('Torque, Nm')