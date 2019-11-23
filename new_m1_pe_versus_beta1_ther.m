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
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1; % model3
beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+r2/r0;
% Pe = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1; % model3
beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+r2/r0;
% Pe = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, '-.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 8; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1; % model3
beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+r2/r0;
% Pe = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, ':.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
% beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+1; % model3
beta2 = sqrt(2/pi)*r1/r0*sqrt(SNR)+r2/r0;
% Pe = 1 - normcdf((beta1.*beta2-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

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

leg = legend('   0 (理论值)', '   5 (理论值)', '   8 (理论值)', ' 10 (理论值)', '   0 (仿真值)', '   5 (仿真值)', '   8 (仿真值)', ' 10 (仿真值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
grid on;