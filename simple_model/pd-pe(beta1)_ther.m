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

% --------------------------
% 最优曲线

SNR1 = -20:0.5:20; % dB
SNR1 = power(10, SNR1 / 10); % 信噪比，原始比例形式

beta2 = ( exp(-SNR1/2) + sqrt(pi/2)*sqrt(SNR1).*(1-2*normcdf(-sqrt(SNR1))) ) * r1/r0 + r2/r0;

Pd = @(beta1)1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR1)); 
Pe = @(beta1)1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR1)); 

A = 2/(pi*r1).*(beta2.^2-1);
B = 2*sqrt(2/(pi*r1))*sqrt(r1)*sqrt(SNR1).*(1-beta2);
C = -2*log(beta2);

beta1Q = (-B+sqrt(B.^2-4*A.*C))./(2*A);
fQ = Pd(beta1Q) - Pe(beta1Q);

plot(beta1Q, fQ, ':', 'color', 'k', 'linewidth', 1.1);

% -------------------------

leg = legend('${\rm SNR}=0{\rm dB}$', '${\rm SNR}=5{\rm dB}$', '${\rm SNR}=8{\rm dB}$', '${\rm SNR}=10{\rm dB}$', '最优');
set(leg, 'interpreter', 'latex');
% title(leg, '${\rm SNR}/{\rm dB}$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d} - P_{e}$', 'interpreter', 'latex');

grid on;
