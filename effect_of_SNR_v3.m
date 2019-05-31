clear, clc;
close all;

SNRdB = 10 * log10(0.0001) : 1 : 10 * log10(10000);
SNR = power(10, SNRdB / 10);

lambda = 1 - 3.0 ./ (4.0 + sqrt(120 .* SNR ./ (29 * pi)));

figure;
plot(SNRdB, lambda, 'linewidth', 2, 'color', 'k');
scrsz = get(0,'ScreenSize'); % 获取屏幕尺寸
% title('SNR 对 \lambda 的影响');
xlabel('SNR(dB)', 'fontsize', 30, 'fontweight', 'bold');
ylabel('\lambda', 'fontsize', 30, 'fontweight', 'bold');
axis([SNRdB(1), SNRdB(end), 0.25, 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(SNRdB(1), SNRdB(end), 21), 'ytick', linspace(0.25, 1, 7), 'fontsize', 22);
grid on;
set(gca, 'gridlinestyle', '--', 'gridcolor', 'k', 'gridalpha', 0.8);
set(gca, 'box', 'off');