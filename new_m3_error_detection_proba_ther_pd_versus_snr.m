% 2. 固定r1，SNR 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，采样率为 22M
r0 = 132; % 

SNR = linspace(0.1, 30, 1000); % 信噪比，原始比例形式
beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1;

beta1 = 60; % 检测门限
Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 70; % 检测门限
Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 1], 'linewidth', 1.3);

% SNR = linspace(0.5, 30, 200); % 信噪比，原始比例形式

beta1 = 80; % 检测门限
Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 0], 'linewidth', 1.3);

beta1 = 90; % 检测门限
Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% --- 仿真值

% beta1 = 60
plot([-10 -7 -5 -4 -3 -2 -1 0 1 2 3 4 5], ...
    [0.0115 0.047 0.01172 0.18775 0.2924 0.424 0.598 0.764 0.895 0.968 0.995 0.999 1], ... 
    ':x', 'color', [0 0 1]);

% beta1 = 70
plot([-1 0 1 2 3 4 5 6 7 8], ...
    [0.0088 0.0225 0.0556 0.1361 0.287 0.514 0.762 0.9287 0.9893 0.999], ... 
    ':s', 'color', [1 0 1]);

% beta1 = 80
plot([4 5 6 7 8 9 10 11], ...
    [0.0024 0.011 0.0471 0.1563 0.3984 0.7174 0.939 0.995], ... 
    ':d', 'color', [1 0 0]);

% beta1 = 90
plot([9 10 11 12 13 14 15], ...
    [0.0035 0.024 0.1206 0.386 0.768 0.9679 0.999], ... 
    ':o', 'color', [60/255 179/255 113/255]);

leg = legend('  60 (理论值)', '  70 (理论值)', '  80 (理论值)', '  90 (理论值)', '  60 (仿真值)', '  70 (仿真值)', '  80 (仿真值)', '  90 (仿真值)');
title(leg, '\beta_{1}');

xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;