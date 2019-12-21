% 2. 固定r1，SNR 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- CFAR

r1 = 44; % 样本数，采样率为 22M

SNR = linspace(0.1, 30, 1000); % 信噪比，原始比例形式

Pfa = 10^-4;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.1);

plot([-10 -8 -6 -4 -2 0 2], ...
    [0.0581 0.14715 0.35075 0.67495 0.92895 0.9981 1], ... 
    ':x', 'color', [0 0 1]);

Pfa = 10^-8;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 1], 'linewidth', 1.1);

plot([-8 -6 -4 -3 -2 -1 0 1 2 3 4], ...
    [0.0027 0.0168 0.0889 0.1989 0.37515 0.6177 0.83485 0.9577 0.9944 0.9999 1], ... 
    ':s', 'color', [1 0 1]);

SNR = linspace(0.1, 30, 100); % 信噪比，原始比例形式

Pfa = 10^-12;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 0], 'linewidth', 1.1);

plot([-4 -3 -2 -1 0 1 2 3 4], ...
    [0.00505 0.0178 0.0542 0.1538 0.35925 0.6467 0.88555 0.98285 0.99935], ... 
    ':d', 'color', [1 0 0]);

Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

plot([-2 -1 0 1 2 3 4 5 6], ...
    [0.0055 0.02055 0.08195 0.25 0.54755 0.84835 0.97805 0.9993 1], ... 
    ':o', 'color', [60/255 179/255 113/255]);

% --- VPP

plot([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15],...
    [0.4898 0.4204 0.3589 0.2957 0.247 0.2014 0.1686 0.151 0.1348 0.1356 0.1484...
    0.1679 0.209 0.269 0.3568 0.4731 0.6 0.7317 0.8388 0.9218 0.9678 0.9901 0.9964 0.9993],...
    ':+', 'color', 'k', 'linewidth', 1.1);

% --- 半峰值功率

plot([-10 -7 -5 -2 0 2 5 10 15], [0.855 0.9287 0.9699 0.995 0.9994 1 1 1 1], ':*', 'color', [1 0.5 0], 'linewidth', 1.1);

leg = legend('  1e-4 (理论值)',...
    '  1e-4 (仿真值)',...
    '  1e-8 (理论值)',...
    '  1e-8 (仿真值)',...
    '1e-12 (理论值)',...
    '1e-12 (仿真值)',...
    '1e-16 (理论值)',...
    '1e-16 (仿真值)',...
    '脉冲位置检测',...
    '3dB门限检测');
title(leg, '$P_{fa}$');
set(leg, 'location', 'northwest', 'interpreter', 'latex');

xlabel('${\rm SNR} / {\rm dB}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
axis([-10 15 0 1]);
grid on;