% clear, clc;
close all;

figure;
hold on;

% --- 理论值

r1 = 44; % 样本数，采样率为 22M
r0 = 132; % 
r2 = r0 - r1;

SNR = linspace(0.1, 80, 1000); % 信噪比，原始比例形式
beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

% ------------------------------

beta1 = 40; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-', 'color', [0 0 1], 'linewidth', 1.1);

% ------------------------------

beta1 = 60; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1);

% ------------------------------

beta1 = 80; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1);

% ------------------------------

beta1 = 100; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

% --------------------------------
% 最优曲线

plot(SNRdBQ, fQ, ':', 'color', 'k', 'linewidth', 1.1);

% --------------------------------

leg = legend('$\beta_{1} = 40$', '$\beta_{1} = 60$', '$\beta_{1} = 80$', '$\beta_{1} = 100$', '最优');
% title(leg, '\beta_{1}');
set(leg, 'location', 'northwest', 'interpreter', 'latex');

xlabel('${\rm SNR} / {\rm dB}$', 'interpreter', 'latex');
ylabel('$P_{d} - P_{e}$', 'interpreter', 'latex');
grid on;




