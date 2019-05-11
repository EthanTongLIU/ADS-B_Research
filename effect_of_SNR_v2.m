clear, clc;
close all;

fun1 = @(x)x .* exp(-power(x, 2));
int1 = @(C)integral(fun1, 0, C);

fun = @(C)1 / ( 1 + 3 / ( 1 - 2 * int1(C) + C * sqrt(pi) * erf(C) ) );

SNRdB = 10 * log10(0.0001) : 1 : 10 * log10(10000);
SNR = power(10, SNRdB / 10);
C = sqrt(30 * SNR / 29);

lambda = zeros(1, length(C));
for i = 1 : length(C)
    lambda(i) = fun(C(i));
end

plot(SNRdB, lambda, 'linewidth', 2, 'color', 'k');
scrsz = get(0,'ScreenSize'); % 获取屏幕尺寸
title('SNR 对 \lambda 的影响');
xlabel('SNR(dB)');
ylabel('\lambda');
axis([SNRdB(1), SNRdB(end), 0.25, 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(SNRdB(1), SNRdB(end), 21), 'ytick', linspace(0.25, 1, 7), 'fontsize', 13);
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);
set(gca, 'box', 'off');

% figure;
% SNRdB = SNRdB - 9;
% plot(SNRdB, lambda, 'linewidth', 2, 'color', 'k');
% scrsz = get(0,'ScreenSize'); % 获取屏幕尺寸
% title('SNR 对 \lambda 的影响');
% xlabel('SNR(dB)');
% ylabel('\lambda');
% axis([SNRdB(1), SNRdB(end), 0.25, 1]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', linspace(SNRdB(1), SNRdB(end), 21), 'ytick', linspace(0.25, 1, 7), 'fontsize', 13);
% grid on;
% set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);
% set(gca, 'box', 'off');