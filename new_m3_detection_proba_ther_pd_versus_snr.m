% 2. 固定r1，SNR 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，采样率为 22M

SNR = linspace(0.5, 30, 1000); % 信噪比，原始比例形式

beta1 = 80; % 检测门限
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 100; % 检测门限
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = linspace(0.5, 30, 200); % 信噪比，原始比例形式

beta1 = 120; % 检测门限
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 0], 'linewidth', 1.3);

beta1 = 140; % 检测门限
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% beta1 = 160; % 检测门限
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
% plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% --- 仿真值

% beta1 = 80
plot([-4 -2 -1 0 1 2 3], ...
    [0.0034 0.0515 0.17385 0.4273 0.754 0.9485 0.9964], ... 
    ':x', 'color', [0 0 1]);

% beta1 = 100
plot([1 2 2.5 3 3.5 4 4.5 5 6 7], ...
    [0.0014 0.01995 0.057 0.12955 0.2726 0.4728 0.6955 0.8697 0.9915 0.999], ... 
    ':s', 'color', [1 0 1]);

% beta1 = 120
plot([5 5.5 6 6.5 7 7.5 8 8.5 9], ...
    [0.0172 0.0627 0.1757 0.39185 0.6547 0.8674 0.9683 0.997 1], ... 
    ':d', 'color', [1 0 0]);

% beta1 = 140
plot([7 7.5 8 8.5 9 9.5 10 10.5 11], ...
    [0.0084 0.0386 0.0144 0.35875 0.6572 0.89235 0.98195 0.998 0.999], ... 
    ':o', 'color', [60/255 179/255 113/255]);

leg = legend('  80 (理论值)', '100 (理论值)', '120 (理论值)', '140 (理论值)', '  80 (仿真值)', '100 (仿真值)', '120 (仿真值)', '140 (仿真值)');
title(leg, '\beta_{1}');

xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;