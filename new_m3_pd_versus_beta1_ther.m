% 1. 固定 r1，beta1 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，选定采样率为 22M

beta1 = linspace(40, 210, 100); % 检测门限

SNR = 0; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, '-.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 8; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, ':.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);


% --- 仿真值

% SNR = 0dB
plot([60 65 70 75 80 85 90 95 100], ...
    [1 0.999 0.9735 0.7994 0.4276 0.1267 0.02185 0.002 0], ... 
    ':x', 'color', [0 0 1]);

% SNR = 5dB
plot([90 95 100 105 110 115 120 125 130], ...
    [0.999 0.97885 0.8678 0.5955 0.276 0.0833 0.01805 0.0029 0], ... 
    ':s', 'color', [1 0 1]);

% SNR = 8dB
plot([110 115 120 125 130 135 140 145 150], ...
    [0.999 0.997 0.9707 0.8596 0.6247 0.347 0.1386 0.0419 0.0089], ... 
    ':d', 'color', [1 0 0]);

% SNR = 10dB
plot([110 130 140 145 150 155 160 165 170 175 180], ...
    [1 0.999 0.979 0.91165 0.747 0.5082 0.2692 0.1116 0.036 0.0104 0.0023], ... 
    ':o', 'color', [60/255 179/255 113/255]);

leg = legend('   0 (理论值)', '   5 (理论值)', '   8 (理论值)', ' 10 (理论值)', '   0 (仿真值)', '   5 (仿真值)', '   8 (仿真值)', ' 10 (仿真值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;