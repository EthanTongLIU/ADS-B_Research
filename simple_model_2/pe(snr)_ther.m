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

plot([-10 -8 -6 -4 -2 0 2], ...
    [0.04925 0.12685 0.29935 0.5839 0.87085 0.9884 0.99985], ... 
    ':x', 'color', [0 0 1]);

Pfa = 10^-8;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1);

plot([-10 -8 -6 -4 -2 0 2 4 6], ...
    [0 0.00195 0.0085 0.049 0.19565 0.561 0.90805 0.9965 1], ... 
    ':s', 'color', [1 0 1]);

SNR = linspace(0.1, 80, 400); % ����ȣ�ԭʼ������ʽ
beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

Pfa = 10^-12;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1);

plot([-4 -2 0 2 4 6], ...
    [0.00155 0.0135 0.0917 0.387 0.8117 0.989], ... 
    ':d', 'color', [1 0 0]);

Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

plot([-2 0 2 4 6 8 10], ...
    [0 0.00815 0.06655 0.3208 0.7604 0.9817 1], ... 
    ':o', 'color', [60/255 179/255 113/255]);

% --- VPP

plot([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15],...
    [0.4898 0.4204 0.3589 0.2957 0.247 0.2014 0.1686 0.151 0.1348 0.1356 0.1484...
    0.1679 0.209 0.269 0.3568 0.4731 0.6 0.7317 0.8388 0.9218 0.9678 0.9901 0.9964 0.9993],...
    ':+', 'color', 'k', 'linewidth', 1.1);

% --- ���ֵ����

plot([-10 -7 -5 -2 0 2 5 10 15], [0.85135 0.9286 0.9684 0.9954 0.99955 1 1 1 1], ':*', 'color', [1 0.5 0], 'linewidth', 1.1);

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