% ����ʦ�޸ĺ�İ汾�ļ�����

format long;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���ۼ�����

%% 1. �̶� r1��beta1 ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������ѡ��������Ϊ 22M

SNR = -10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = -3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 0; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('-10 (����ֵ)', '  -3 (����ֵ)', '   0 (����ֵ)', '   3 (����ֵ)', ' 10 (����ֵ)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

% plot([50 55 60 65 70 75 80 85 90 100 110 120 125], ...
%     [1, 0.998 0.992 0.974 0.929 0.845 0.727 0.579 0.419 0.179 0.062 0.0162 0.0082], ...
%     '-o', 'color', [60/255 179/255 113/255]);

% plot([50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125], ...
%     [1 1 1 1 1 1 0.999 0.993 0.938 0.76 0.48 0.22 0.081 0.023 0.005 0.0014], ...
%     '-o', 'color', [60/255 179/255 113/255]);

plot([130 140 150 160 170 180], ...
    [0.998 0.977 0.747 0.269 0.038 0.001], ...
    '-o', 'color', [60/255 179/255 113/255]);

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;

%% 2. �̶�r1��SNR ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������������Ϊ 22M

SNR = linspace(0.1, 20, 1000); % ����ȣ�ԭʼ������ʽ

beta1 = 20; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 30; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = linspace(0.1, 20, 200); % ����ȣ�ԭʼ������ʽ

beta1 = 40; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

beta1 = 50; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

beta1 = 60; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('20 (����ֵ)', '30 (����ֵ)', '40 (����ֵ)', '50 (����ֵ)', '60 (����ֵ)');
title(leg, '\beta_{1}');
xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;

%% 3. �̶�r1��Pfa ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������������Ϊ 22M

Pfa = linspace(1e-9, 1e-3, 100000);

SNR = 5; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

Pfa = linspace(1e-9, 1e-3, 50000);

SNR = 5.5; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 6; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 6.5; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

% �����Ƿ���Ľ��

logPfa = log10([1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3]);
% SNR = 5dB;
Pd = [0.17275 0.2475 0.34795 0.4663 0.6 0.74935 0.87965];
plot(logPfa, Pd, '-o', 'color', [0 0 1]);
% SNR = 5.5dB;
Pd = [0.2402 0.33035 0.437 0.5694 0.70925 0.83525 0.931];
plot(logPfa, Pd, '-*', 'color', [1 0 0]);
% SNR = 6dB;
Pd = [0.3159 0.4212 0.54425 0.67825 0.792 0.898 0.9657];
plot(logPfa, Pd, '-v', 'color', [1 0.65 0]);
% SNR = 6.5dB;
Pd = [0.4025 0.5219 0.64275 0.7631 0.874 0.9453 0.9852];
plot(logPfa, Pd, '-^', 'color', [1 0 1]);
% SNR = 10dB;
Pd = [0.94685 0.9783 0.99475 0.99835 0.9998 1 1];
plot(logPfa, Pd, '->', 'color', [60/255 179/255 113/255]);

leg = legend('    5 (����ֵ)', ' 5.5 (����ֵ)', '    6 (����ֵ)', ' 6.5 (����ֵ)', '  10 (����ֵ)', ...
    '    5 (����ֵ)', ' 5.5 (����ֵ)', '    6 (����ֵ)', ' 6.5 (����ֵ)', '  10 (����ֵ)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');

xlabel('$P_{fa}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');

set(gca, 'xtick', [-9 -8 -7 -6 -5 -4 -3], 'xticklabel', {'1e-9', '1e-8', '1e-7', '1e-6', '1e-5', '1e-4', '1e-3'});

grid on;



















