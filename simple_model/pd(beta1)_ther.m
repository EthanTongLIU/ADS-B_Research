% 1. 固定 r1，beta1 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，选定采样率为 22M

beta1 = linspace(10, 220, 100); % 检测门限

SNR = 0; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, '-.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 8; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, ':.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);


% --- 仿真值

% SNR = 0dB
plot([20 30 35 40 45 50 55 60 65 70 75 80], ...
    [1 0.9985 0.9904 0.9592 0.8746 0.72 0.506 0.3009 0.1497 0.059 0.0197 0.0053], ... 
    ':x', 'color', [0 0 1]);

% SNR = 5dB
plot([60 70 80 85 90 95 100 105 110 115 120 130], ...
    [0.999 0.998 0.966 0.91 0.79 0.624 0.425 0.26 0.14 0.064 0.0264 0.0032], ... 
    ':s', 'color', [1 0 1]);

% SNR = 8dB
plot([100 110 120 125 130 135 140 145 150 155 165 170], ...
    [0.999 0.995 0.947 0.88 0.769 0.619 0.45 0.307 0.186 0.107 0.026 0.011], ... 
    ':d', 'color', [1 0 0]);

% SNR = 10dB
plot([140 150 160 165 170 175 180 185 190 195 200 210], ...
    [0.9973 0.9682 0.859 0.75 0.629 0.485 0.354 0.242 0.153 0.087 0.049 0.014], ... 
    ':o', 'color', [60/255 179/255 113/255]);

leg = legend('   0 (理论值)', '   5 (理论值)', '   8 (理论值)', ' 10 (理论值)', '   0 (仿真值)', '   5 (仿真值)', '   8 (仿真值)', ' 10 (仿真值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;























