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

SNR = linspace(0.1, 80, 200); % ����ȣ�ԭʼ������ʽ
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