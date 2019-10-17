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
xlabel('\beta_{1}');
ylabel('P_{e}');

beta1 = linspace(0.1, 100, 100);

for SNR = pi / 4 : pi / 4 : pi
    beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
    Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
    plot(beta1, Pe, 'color', 'b');
end

%% SNR 作为横轴

figure;
hold on;
xlabel('SNR');
ylabel('P_{e}');

SNR = linspace(0.5, 5, 100);

for beta1 = 0.1 : 10 : 100
    beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
    Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
    plot(SNR, Pe, 'color', 'b');
end

plot([pi/2, pi/2], [0, 1], '-.', 'color', 'r');



