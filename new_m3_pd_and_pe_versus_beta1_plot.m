% 1. 固定 r1，beta1 作为横轴

clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，选定采样率为 22M

beta1 = linspace(0, 90, 15); % 检测门限

SNR = 1.96; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, ':x', 'color', [0 0 1], 'linewidth', 1.3);

% beta1 = linspace(95, 120, 15); % 检测门限
% 
% SNR = 5; % 信噪比，dB形式
% SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
% plot(beta1, Pd, ':s', 'color', [1 0 1], 'linewidth', 1.3);
% 
% beta1 = linspace(120, 145, 15); % 检测门限
% 
% SNR = 8; % 信噪比，dB形式
% SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
% plot(beta1, Pd, ':d', 'color', [1 0 0], 'linewidth', 1.3);
% 
% beta1 = linspace(140, 170, 15); % 检测门限
% 
% SNR = 10; % 信噪比，dB形式
% SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
% plot(beta1, Pd, ':o', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);


% --- 仿真值

% % SNR = 0dB
% plot([60 65 70 75 80 85 90 95 100], ...
%     [1 0.999 0.9735 0.7994 0.4276 0.1267 0.02185 0.002 0], ... 
%     ':x', 'color', [0 0 1]);
% 
% % SNR = 5dB
% plot([90 95 100 105 110 115 120 125 130], ...
%     [0.999 0.97885 0.8678 0.5955 0.276 0.0833 0.01805 0.0029 0], ... 
%     ':s', 'color', [1 0 1]);
% 
% % SNR = 8dB
% plot([110 115 120 125 130 135 140 145 150], ...
%     [0.999 0.997 0.9707 0.8596 0.6247 0.347 0.1386 0.0419 0.0089], ... 
%     ':d', 'color', [1 0 0]);
% 
% % SNR = 10dB
% plot([110 130 140 145 150 155 160 165 170 175 180], ...
%     [1 0.999 0.979 0.91165 0.747 0.5082 0.2692 0.1116 0.036 0.0104 0.0023], ... 
%     ':o', 'color', [60/255 179/255 113/255]);

% --- 理论值

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 

beta1 = linspace(0, 75, 30); % 检测门限

SNR = 1.96; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1;
Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

% beta1 = linspace(60, 80, 30); % 检测门限
% 
% SNR = 5; % 信噪比，dB形式
% SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1;
% Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
% plot(beta1, Pd, '-.', 'color', [1 0 1], 'linewidth', 1.3);
% 
% beta1 = linspace(70, 88, 30); % 检测门限
% 
% SNR = 8; % 信噪比，dB形式
% SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1;
% Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
% plot(beta1, Pd, ':.', 'color', [1 0 0], 'linewidth', 1.3);
% 
% beta1 = linspace(75, 90, 30); % 检测门限
% 
% SNR = 10; % 信噪比，dB形式
% SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1;
% Pd = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% % Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
% plot(beta1, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% --- 仿真值

% % SNR = 0dB
% plot([50 55 57 59 60 61 63 65 67 69 70 75], ...
%     [1 0.988 0.9451 0.847 0.7593 0.661 0.441 0.2442 0.109 0.0398 0.02205 0], ... 
%     ':x', 'color', [0 0 1]);
%
% % SNR = 5dB
% plot([65 67 69 70 72 74 75 77 79 80 85], ...
%     [0.9893 0.9544 0.8507 0.76595 0.53 0.297 0.2052 0.0756 0.0245 0.0104 0], ... 
%     ':s', 'color', [1 0 1]);
% 
% % SNR = 8dB
% plot([70 72 74 75 76 78 80 82 84 85 90], ...
%     [0.999 0.9946 0.9644 0.9298 0.8644 0.6633 0.40025 0.1826 0.0623 0.03085 0], ... 
%     ':d', 'color', [1 0 0]);
% 
% % SNR = 10dB
% plot([75 76 78 80 82 84 85 86 88 90 95], ...
%     [0.999 0.999 0.988 0.938 0.787 0.522 0.38045 0.2632 0.0929 0.0245 0], ... 
%     ':o', 'color', [60/255 179/255 113/255]);

leg = legend('~0~($P_{d}$)', '~5~($P_{d}$)', '~8~($P_{d}$)', '10~($P_{d}$)', '~0~($P_{e}$)', '~5~($P_{e}$)', '~8~($P_{e}$)', '10~($P_{e}$)');
set(leg, 'interpreter', 'latex');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d} ~ or ~ P_{e}$', 'interpreter', 'latex');
% axis([40 190 0 1]);
grid on;