% Функция для исследования осциллятора Ван дер Поля
a_values = [0, 0.5, 1.5];
%a_values = [300];

% Определение временного интервала и начальных условий
tspan = [0, 20];
x0 = [0; 4];
A = 0;
w = 5;
% Папка для сохранения изображений
output_folder = 'phase_portraits';
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Цикл по значениям параметра a
for i = 1:length(a_values)
    a = a_values(i);

    % Вызов ode45 для численного решения
    [t, y] = ode45(@(t, y) VanDerPol(t, y, a, A, w), tspan, x0);

    % Отображение фазового портрета
    figure;
    plot(y(:, 1), y(:, 2), 'b');
    xlabel('x');
    ylabel('y');
    title(['Van der Pol Phase Portrait, a = ' num2str(a)]);
    grid on;

    % Сохранение изображения
    filename = fullfile(output_folder, ['out phase_portrait_a_' num2str(a) '.png']);
    saveas(gcf, filename);
    close(gcf); % Закрываем текущее окно графика
end