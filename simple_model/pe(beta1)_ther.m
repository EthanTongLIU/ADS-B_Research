% 1. 固定 r1，beta1 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 
r2 = r0 - r1;

beta1 = linspace(10, 100, 500); % 检测门限

SNR = 0; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
xi = floor((1-2*normcdf(-sqrt(SNR)))*r1)
beta2 = sqrt(pi/2)*xi/r0*sqrt(SNR)+r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
xi = floor((1-2*normcdf(-sqrt(SNR)))*r1)
beta2 = sqrt(pi/2)*xi/r0*sqrt(SNR)+r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, '-.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 8; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
xi = floor((1-2*normcdf(-sqrt(SNR)))*r1)
beta2 = sqrt(pi/2)*xi/r0*sqrt(SNR)+r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, ':.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
xi = floor((1-2*normcdf(-sqrt(SNR)))*r1)
beta2 = sqrt(pi/2)*xi/r0*sqrt(SNR)+r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% --- 仿真值

% SNR = 0dB
plot([20 30 35 40 45 50 55 60 70], ...
    [0.999 0.992 0.955 0.847 0.637 0.393 0.186 0.068 0.004], ... 
    ':x', 'color', [0 0 1]);

% SNR = 5dB
plot([40 50 55 60 65 70 75 80 90], ...
    [1 0.998 0.983 0.911 0.7134 0.435 0.2001 0.066 0.0026], ... 
    ':s', 'color', [1 0 1]);

% SNR = 8dB
plot([60 70 75 80 85 90 100], ...
    [0.999 0.965 0.824 0.548 0.253 0.0702 0.003], ... 
    ':d', 'color', [1 0 0]);

% SNR = 10dB
plot([70 80 85 90 95 100 110], ...
    [0.999 0.923 0.695 0.346 0.106 0.019 0], ... 
    ':o', 'color', [60/255 179/255 113/255]);

leg = legend('   0 (理论值)', '   5 (理论值)', '   8 (理论值)', ' 10 (理论值)', '   0 (仿真值)', '   5 (仿真值)', '   8 (仿真值)', ' 10 (仿真值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
axis([10 120 0 1]);
grid on;