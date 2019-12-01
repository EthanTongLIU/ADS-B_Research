% clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 
r2 = r0 - r1;

beta1 = linspace(10, 220, 100); % 检测门限

% ----------------------

SNR = 0; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
beta2 = ( exp(-SNR/2) + sqrt(SNR)*sqrt(pi/2)*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd - Pe, '-', 'color', [0 0 1], 'linewidth', 1.1);

% ----------------------

SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
beta2 = ( exp(-SNR/2) + sqrt(SNR)*sqrt(pi/2)*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd - Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1);

% ----------------------

SNR = 8; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
beta2 = ( exp(-SNR/2) + sqrt(SNR)*sqrt(pi/2)*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd - Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1);

% ----------------------

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
beta2 = ( exp(-SNR/2) + sqrt(SNR)*sqrt(pi/2)*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(beta1, Pd - Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

leg = legend('   0', '   5', '   8', ' 10');
title(leg, '${\rm SNR}/{\rm dB}$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d} - P_{e}$', 'interpreter', 'latex');
grid on;

plot(beta1Q, fQ, ':');


