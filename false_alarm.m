%% 两个概率密度分布
format long;
clear, clc;
close all;

x = linspace(-0.2, 0.4, 2000);

H = 2.0 - pi / 2.0;
K = 0.35; % 0.35
N = 100; % 100

figure;
hold on;

annotationy = annotation('arrow',[0.12986 0.12986],[0.92 0.96]);
annotationx = annotation('arrow',[0.88 0.94],[0.1096 0.1096]);

for i = 1 : 1
    N = 100 * i;
    
    u1 = 0;
    d1 = H / (4 * N);

    u2 = (K - 0.25) * sqrt(pi / 2);
    d2 = H / N * K .^ 2;

    f1 = 1.0 / sqrt(2 * pi * d1) * exp(-(x - u1) .^ 2 / (2 * d1));
    f2 = 1.0 / sqrt(2 * pi * d2) * exp(-(x - u2) .^ 2 / (2 * d2));

    plot(x, f1, 'color', 'r', 'linewidth', 1.5);
    plot(x, f2, 'color', 'b', 'linewidth', 1.5);
    plot([u1 u1], [0 20], '--', 'linewidth', 1, 'color', 'r');
    plot([u2 u2], [0 20], '--', 'linewidth', 1, 'color', 'b');
    
    annotation('arrow', [0.63 0.58], [0.65 0.6]);
    text(0.18, 13.8, '\fontsize{18}f(u^{\prime})');
    annotation('arrow', [0.455 0.405], [0.63 0.58]);
    text(0.044, 13.3, '\fontsize{18}f(u)'); 
end

vec_pos_x = get(get(gca, 'XLabel'), 'Position');
set(get(gca, 'XLabel'), 'Position', vec_pos_x + [0.26 1.2 0]);

vec_pos_y = get(get(gca, 'YLabel'), 'Position');
set(get(gca, 'YLabel'), 'Position', vec_pos_y + [0.03 9.5 0]);

xlabel('u / u^{\prime}', 'fontsize', 18);
ylabel('f(u) / f(u^{\prime})', 'fontsize', 18);
axis([-0.2 0.4 0 20]);
set(gca, 'box', 'off', 'xtick', [u1 u2], 'ytick', [], 'fontsize', 18);
set(gca,'TickLabelInterpreter', 'latex');
set(gca, 'xticklabel', {'0', '$$\left(\lambda - \frac{1}{4}\right) \sqrt{\frac{\pi}{2}}$$'});

%%
x = linspace(-5, 5, 2000);
H = 2.0 - pi / 2.0;
K = 0.35; % 0.35
N = 100; % 100

figure;
hold on;
    
u1 = 0;
d1 = H / (4 * N);

u2 = (K - 0.25) * sqrt(pi / 2);
d2 = H / N * K .^ 2;

f1 = 1.0 / sqrt(2 * pi * d1) * exp(-(x - u1) .^ 2 / (2 * d1));
f2 = 1.0 / sqrt(2 * pi * d2) * exp(-(x - u2) .^ 2 / (2 * d2));

plot(x, f1, 'color', 'r', 'linewidth', 1.5);
plot(x, f2, 'color', 'b', 'linewidth', 1.5);
plot([u1 u1], [0 max(f1)], '--', 'linewidth', 1, 'color', 'r');
plot([u2 u2], [0 max(f2)], '--', 'linewidth', 1, 'color', 'b');


%% 总的虚警率
figure;
hold on;
for j = 1 : 2 : 15
    K = 0.25 + (j - 1) * 0.05;
    P = zeros(1, 10);
    for i = 1 : 20
        N = i * 10;
        u1 = 0;
        d1 = H / (4 * N);

        u2 = (K - 0.25) * sqrt(pi / 2);
        d2 = H / N * K .^ 2;

        fun3 = @(x)0.5 * 1 / sqrt(2 * pi * d2) * erfc(x / sqrt(2 * d1)) .* exp( - (x - u2) .^ 2 / (2 * d2));

        P(i) = integral(fun3, -3, 3);
    end
    xb = 10 : 10 : 200;
%     plot(xb, log10(P), '-s', 'linewidth', 2, 'color', 'k');
%     text(160, log10(P(17)) - 1, ['\lambda = ', num2str(K)]);
    if j == 1
        plot(xb, log10(P), '-+', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 3
        plot(xb, log10(P), '-x', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 5
        plot(xb, log10(P), '-*', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 7
        plot(xb, log10(P), '-o', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 9
        plot(xb, log10(P), '-s', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 11
        plot(xb, log10(P), '-d', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 13
        plot(xb, log10(P), '-^', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    elseif j == 15
        plot(xb, log10(P), '-v', 'linewidth' , 1.5, 'color', 'k', 'markersize', 13);
    end
end
axis([xb(1) xb(end) -70 0]);
set(gca, 'box', 'off', 'xtick', linspace(10, 200, 20), 'fontsize', 22);
leg = legend(['\lambda =', num2str(0.25)], ['\lambda =', num2str(0.35)], ['\lambda =', num2str(0.45)], ['\lambda =', num2str(0.55)], ['\lambda =', num2str(0.65)], ['\lambda =', num2str(0.75)], ['\lambda =', num2str(0.85)], ['\lambda =', num2str(0.95)]);
set(leg, 'fontsize', 25);
xlabel('滑窗内采样点数 N', 'fontsize', 30, 'fontweight', 'bold');
ylabel('对数虚警概率 logP', 'fontsize', 30, 'fontweight', 'bold');
grid on;
set(gca, 'gridlinestyle', '--', 'gridalpha', 0.8);

%% 单 R 恒虚警
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
