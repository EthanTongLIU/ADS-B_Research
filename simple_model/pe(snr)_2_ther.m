% 2. �̶�r1��SNR ��Ϊ����

clear, clc;
close all;

figure;
hold on;

% --- CFAR

r1 = 44; % ��������������Ϊ 22M
r0 = 132; % 
r2 = r0 - r1;

SNR = linspace(0.1, 80, 1000); % ����ȣ�ԭʼ������ʽ
beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

Pfa = 10^-4;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, '-', 'color', [0 0 1], 'linewidth', 1.1);

% plot([-2 -1 0 1 2 3 4 5 6 7], ...
%     [0.007 0.026 0.067 0.157 0.32 0.527 0.754 0.907 0.979 0.998], ... 
%     ':x', 'color', [0 0 1]);

Pfa = 10^-8;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1);

% plot([-1 0 1 2 3 4 5 6 7 8 9 10], ...
%     [0.002 0.004 0.013 0.045 0.1124 0.2425 0.4453 0.6735 0.863 0.963 0.995 0.999], ... 
%     ':s', 'color', [1 0 1]);

SNR = linspace(0.1, 80, 200); % ����ȣ�ԭʼ������ʽ
beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

Pfa = 10^-12;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1);

% plot([2 3 4 5 6 7 8 9 10 11 12], ...
%     [0.002 0.0075 0.025 0.0654 0.1558 0.32 0.549 0.771 0.924 0.986 0.999], ... 
%     ':d', 'color', [1 0 0]);

Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

% plot([5 6 7 8 9 10 11 12 13 14 15], ...
%     [0.003 0.011 0.029 0.075 0.169 0.343 0.5754 0.812 0.952 0.994 0.999], ... 
%     ':o', 'color', [60/255 179/255 113/255]);

% --- VPP


% --- ���ֵ����


leg = legend('  1e-4 (����ֵ)',...
    '  1e-4 (����ֵ)',...
    '  1e-8 (����ֵ)',...
    '  1e-8 (����ֵ)',...
    '1e-12 (����ֵ)',...
    '1e-12 (����ֵ)',...
    '1e-16 (����ֵ)',...
    '1e-16 (����ֵ)',...
    '����λ�ü��',...
    '3dB���޼��');
title(leg, '$P_{fa}$');
set(leg, 'location', 'northwest', 'interpreter', 'latex');

xlabel('${\rm SNR} / {\rm dB}$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
axis([-10 15 0 1]);
grid on;