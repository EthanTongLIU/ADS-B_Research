% 将虚假报头检测为报头的概率 Pe

clear, clc;
close all;
format long;

% 理论值

% 采样率 22M，则 8us 样本数为 176，r1 = 44，r0 = 132
r1 = 44;
r0 = 132;
r2 = r0 - r1;

%% beta1 作为横轴

figure;
hold on;

beta1 = linspace(0.1, 110, 100);

SNR = -10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = -3; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 0; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 1.9612; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '-..', 'color', 'k', 'linewidth', 1.0);

SNR = 3; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(beta1, Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('  -10 (理论值)', '    -3 (理论值)', '     0 (理论值)', '1.96 (理论值)', '     3 (理论值)', '   10 (理论值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');
xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
grid on;

%% SNR 作为横轴

figure;
hold on;

SNR = linspace(0.1, 20, 1000); % 信噪比，原始比例形式

beta1 = 20;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 30;
beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
plot(10*log10(SNR), Pe, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = linspace(0.1, 20, 100); % 信噪比，原始比例形式

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

plot([10*log10(pi/2), 10*log10(pi/2)], [0, 1], '-..', 'color', 'k'); % 临界信噪比

leg = legend('20 (理论值)', '30 (理论值)', '40 (理论值)', '50 (理论值)', '60 (理论值)');
title(leg, '\beta_{1}');
set(gca, 'xtick', [-10 -5 0 1.96 5 10 15], 'xticklabel', {'-10', '-5', '0', '1.96', '5', '10', '15'});
xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{e}$', 'interpreter', 'latex');
grid on;



