% ����ٱ�ͷ���Ϊ��ͷ�ĸ��� Pe

clear, clc;
close all;
format long;

% ����ֵ

% ������ 22M���� 8us ������Ϊ 176��r1 = 44��r0 = 132
r1 = 44;
r0 = 132;
r2 = r0 - r1;

%% beta1 ��Ϊ����

figure;
hold on;

beta1 = linspace(0.1, 110, 100);

SNR = -10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = -3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 0; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 1.9612; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '-..', 'color', 'k', 'linewidth', 1.0);

SNR = 3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('  -10 (����ֵ)', '    -3 (����ֵ)', '     0 (����ֵ)', '1.96 (����ֵ)', '     3 (����ֵ)', '   10 (����ֵ)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');
xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
grid on;

%% SNR ��Ϊ����

figure;
hold on;

SNR = linspace(0.1, 20, 1000); % ����ȣ�ԭʼ������ʽ

beta1 = 20;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 30;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = linspace(0.1, 20, 100); % ����ȣ�ԭʼ������ʽ

beta1 = 40;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

beta1 = 50;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, ':.', 'color', [1 0 1], 'linewidth', 1.3);

beta1 = 60;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

plot([10*log10(pi/2), 10*log10(pi/2)], [0, 1], '-..', 'color', 'k'); % �ٽ������

leg = legend('20 (����ֵ)', '30 (����ֵ)', '40 (����ֵ)', '50 (����ֵ)', '60 (����ֵ)');
title(leg, '\beta_{1}');
set(gca, 'xtick', [-10 -5 0 1.96 5 10 15], 'xticklabel', {'-10', '-5', '0', '1.96', '5', '10', '15'});
xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
grid on;



