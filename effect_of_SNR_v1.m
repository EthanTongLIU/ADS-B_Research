clear, clc;
close all;

A = 40;
n = 11;

fun1 = @(x)exp(-power(x, 2));
int1 = @(A)integral(fun1, -A, A);

fun2 = @(x)x .* exp(-power(x, 2));
int2 = @(A, sigma)integral(fun2, -A / (sqrt(2) * sigma), A / (sqrt(2) * sigma));

int3 = @(A, sigma)-1 / sqrt(pi) * sqrt(2) * sigma * integral(fun2, -1000, -A/(sqrt(2) * sigma)) -A / sqrt(pi) * integral(fun1, -1000, -A/(sqrt(2) * sigma)) + 1 / sqrt(pi) * sqrt(2) * sigma * integral(fun2, -A/(sqrt(2) * sigma), 1000) + A / sqrt(pi) * integral(fun1, -A/(sqrt(2) * sigma), 1000);


SNRdB = 10 * log10(0.0001) : 1 : 10 * log10(10000);
rate = zeros(1, length(SNRdB));
for i = 1 : length(SNRdB)
    SNR = power(10, SNRdB(i) / 10);
    sigma = sqrt(29 * A ^ 2 / (60 * SNR));
    mu_n = sqrt(2 / pi) * sigma;
    mu_p = int3(A, sigma);
    mean_pre = mu_p / 4 + 0.75 * mu_n;
    conv_pre = mu_p * 4 * n;
    rate(i) = conv_pre / mean_pre;
end

rate = rate / n;

plot(SNRdB, rate, 'linewidth', 2, 'color', 'k');
% plot(power(10, SNRdB / 10), rate, 'linewidth', 2, 'color', 'k');
scrsz = get(0,'ScreenSize'); % 获取屏幕尺寸
title('信噪比对报头检测门限的影响（Rate=卷积和/电平均值）');
xlabel('SNR(dB)');
ylabel('Rate');
% axis([SNRdB(1) SNRdB(end) 4 16]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(SNRdB(1), SNRdB(end), 21), 'ytick', linspace(4, 16, 13), 'fontsize', 13);
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);
set(gca, 'box', 'off');
% set(gca, 'xscale', 'log')%将x轴上刻度单位设置为对数坐标型


