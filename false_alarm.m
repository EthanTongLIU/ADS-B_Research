clear, clc;
close all;

x = linspace(-2, 4, 1000);

H = 2 - pi / 2.0;
K = 0.3;
N = 100;

for i = 1 : 1
    N = 100 * i;
    
    u1 = 0;
    d1 = H / (4 * N);

    u2 = 3.0 / 4.0 * sqrt(pi / 2);
    d2 = H / N * K .^ 2;

    f1 = 1.0 / sqrt(2 * pi * d1) * exp(-(x - u1) .^ 2 / (2 * d1));
    f2 = 1.0 / sqrt(2 * pi * d2) * exp(-(x - u2) .^ 2 / (2 * d2));

    plot(x, f1, 'color', 'r', 'linewidth', 1.5);
    hold on;
    plot(x, f2, 'color', 'b', 'linewidth', 1.5);
    hold on;
    legend('f(u)', 'f(u^{\prime})');
    annotation('arrow', [0.6 0.55], [0.2 0.15]);
    text(1.5, 2, '\fontsize{15}f(u^{\prime})');
end

%% 
figure;
x0 = 0.05;
for j = 1 : 5
    N = 5;
    q = zeros(1, 50);
    for i = 1 : 50
        fun = @(y) 1 / sqrt(2 * pi) * sqrt(N / (4 * H)) * exp( - N * y .^ 2 / (8 * H) );
        q(i) = integral(fun, x0, 10000);
        N = N + 20;
    end
    if j == 1
        plot(5 : 20 : 1000, q, '-s', 'linewidth', 1, 'color', 'k');
    elseif j == 2
        plot(5 : 20 : 1000, q, '-d', 'linewidth', 1, 'color', 'k');
    elseif j == 3
        plot(5 : 20 : 1000, q, '-v', 'linewidth', 1, 'color', 'k');
    elseif j == 4
        plot(5 : 20 : 1000, q, '-x', 'linewidth', 1, 'color', 'k');
    elseif j == 5
        plot(5 : 20 : 1000, q, '-o', 'linewidth', 1, 'color', 'k');
    end
    hold on;
    x0 = x0 + 0.05;
end
legend(['归一化检测门限', num2str(0.05)], ['归一化检测门限', num2str(0.1)], ['归一化检测门限', num2str(0.15)], ['归一化检测门限', num2str(0.2)], ['归一化检测门限', num2str(0.25)]);
xlabel('单元个数 N', 'fontsize', 18);
ylabel('虚警概率 P', 'fontsize', 18);
title('虚警概率 P 与单元个数 N 和归一化检测门限的关系', 'fontsize', 18);
