% 2. �̶�r1��SNR ��Ϊ����

clear, clc;
close all;

figure;
hold on;

% --- ����ֵ

r1 = 44; % ��������������Ϊ 22M

SNR = linspace(0.1, 15, 1000); % ����ȣ�ԭʼ������ʽ

beta1 = 40; % �������
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.1);

beta1 = 60; % �������
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 1], 'linewidth', 1.1);

SNR = linspace(0.1, 15, 100); % ����ȣ�ԭʼ������ʽ

beta1 = 80; % �������
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 0], 'linewidth', 1.1);

beta1 = 100; % �������
% Pd = 1 - normcdf((beta1-r1).*sqrt(pi/((4-pi)*r1)) - sqrt(2*r1.*SNR./(4-pi))); % model3
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

% --- ����ֵ

% beta1 = 40
plot([-8 -6 -4 -2 -1 0 1], ...
    [0.019 0.0806 0.276 0.67255 0.8505 0.95775 0.9944], ... 
    ':x', 'color', [0 0 1]);

% beta1 = 60
plot([-2 -1 0 1 2 3 4], ...
    [0.0384 0.11905 0.2927 0.585 0.8485 0.974 0.999], ... 
    ':s', 'color', [1 0 1]);

% beta1 = 80
plot([1 2 3 4 5 6], ...
    [0.034 0.136 0.411 0.77535 0.966 0.999], ... 
    ':d', 'color', [1 0 0]);

% beta1 = 100
plot([3 4 5 6 7 8], ...
    [0.0174 0.1175 0.4244 0.8307 0.9867 0.999], ... 
    ':o', 'color', [60/255 179/255 113/255]);

leg = legend('  40 (����ֵ)', '  60 (����ֵ)', '  80 (����ֵ)', '100 (����ֵ)', '  40 (����ֵ)', '  60 (����ֵ)', '  80 (����ֵ)', '100 (����ֵ)');
title(leg, '\beta_{1}');
set(leg, 'location', 'northwest');

xlabel('${\rm SNR} / {\rm dB}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
axis([-10 10 0 1]);
grid on;