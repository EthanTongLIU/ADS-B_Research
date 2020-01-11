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

% --- CFAR

Pfa = 10^-4;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-', 'color', [0 0 1], 'linewidth', 1.1, 'markersize', 3);

Pfa = 10^-8;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1, 'markersize', 3);

Pfa = 10^-12;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1, 'markersize', 4);

Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1, 'markersize', 3);

% CFAR 最优

plot(SNRdBQ, fQ, '-', 'color', 'k', 'linewidth', 1.1, 'markersize', 3);

% --- VPP

plot([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15],...
    zeros(1, length([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15])),...
    ':+', 'color', 'k', 'linewidth', 1.1, 'markersize', 3);

% --- 半峰值功率

plot([-10 -7 -5 -2 0 2 5 10 15], [0.855 0.9287 0.9699 0.995 0.9994 1 1 1 1] - [0.85135 0.9286 0.9684 0.9954 0.99955 1 1 1 1], ':*', 'color', [1 0.5 0], 'linewidth', 1.1, 'markersize', 3);

leg = legend('$P_{fa} = 10^{-4}$ (CFAR)',...
    '$P_{fa} = 10^{-8}$ (CFAR)',...
    '$P_{fa} = 10^{-12}$ (CFAR)',...
    '$P_{fa} = 10^{-16}$ (CFAR)',...
    '不同虚警率的极值点',...
    '脉冲位置检测',...
    '3dB门限检测');
% title(leg, '$P_{fa}$');
set(leg, 'location', 'best', 'interpreter', 'latex', 'box', 'off', 'fontname', 'Euclid');

% --- 设置绘图参数
set(gcf, 'units', 'centimeters', 'Position', [12 12 6 4]);%设置图片大小为 6cm×6cm

xlabel('${\rm SNR} ( {\rm dB} )$', 'interpreter', 'latex');
ylabel('$P_{d} - P_{e}$', 'interpreter', 'latex');
set(get(gca, 'xlabel'), 'fontsize', 7, 'fontname', 'euclid'); % 坐标轴标签
set(get(gca, 'ylabel'), 'fontsize', 7, 'fontname', 'euclid'); % 坐标轴标签
set(gca, 'fontsize', 7, 'fontname', 'euclid'); % 坐标轴
set(gca, 'linewidth', 0.5); % 坐标轴线粗0.5磅
set(gca, 'box', 'on');
set(get(gca,'Children'), 'linewidth', 0.5); %设置图中线宽0.5磅

axis([-10 15 -0.05 1]);
grid on;
set(gca, 'gridlinestyle', ':', 'GridColor', 'k', 'gridalpha', 1);




