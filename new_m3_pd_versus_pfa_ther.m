% 3. �̶�r1��Pfa ��Ϊ����
format long;
clear, clc;
close all;

figure;
hold on;

% --- ����ֵ

r1 = 44; % ��������������Ϊ 22M

Pfa = linspace(1e-14, 0.9999999999999999, 1000);
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
max(beta1)
min(beta1)

SNR = -4; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(Pfa, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = -3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(Pfa, Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = -2; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(Pfa, Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = -1; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(Pfa, Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 0; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
% Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(Pfa, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% --- ����ֵ

leg = legend('    -10 (����ֵ)', ' -9 (����ֵ)', '    -8 (����ֵ)', ' -7 (����ֵ)', '  -6 (����ֵ)', ...
    '    5 (����ֵ)', ' 5.5 (����ֵ)', '    6 (����ֵ)', ' 6.5 (����ֵ)', '  10 (����ֵ)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$P_{fa}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');

% set(gca, 'xtick', [-9 -8 -7 -6 -5 -4 -3], 'xticklabel', {'1e-9', '1e-8', '1e-7', '1e-6', '1e-5', '1e-4', '1e-3'});

grid on;