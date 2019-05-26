%%
clear, clc;
close all;

fs = 22; % MHz 采样频率，应大于 2 * 1090
Tb = 1; % us
t0 = -80 : 1/fs : 200; % 时间序列，其中 0-120 为 ADS-B 报文
b = @(t, d)(d - 0.5)*(rect(t) - rect(t - Tb / 2.0));

scrsz = get(0,'ScreenSize'); % 获取屏幕尺寸

% >>> 构建报头 <<<
h = zeros(1, length(t0));
for i = 0 : 1 : 15
    h = h + (-0.5) * rect(t0 - i * Tb / 2);
end
h = h + rect(t0) + rect(t0 - 1) + rect(t0 - 3.5) + rect(t0 - 4.5);

% >>> 构建数据报文 <<<
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

% >>> 合成基带信号 <<<
a = h + d;
for k = 0 : 1 : 239
    a = a + 0.5 * rect(t0 - k * Tb / 2);
end

% >>> 改变基带信号电平 <<<
A = 40;
a = A * a;

figure;
plot(t0, a, 'color', 'k', 'linewidth', 1.5);
title('基带信号a');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -A 2 * A]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

%%
% >>> 加入瑞利分布的噪声 <<<
% 测量信号功率
sigPower = 29 * A^2 / 60;
SNR = 1; % 比例形式
noisePower = sigPower / SNR;
noise = raylrnd(sqrt(noisePower), 1, length(a));
y = a + noise;

figure;
plot(t0, y, 'color', 'k', 'linewidth', 1);
title(['加噪基带信号y（信噪比SNR=',num2str(SNR),'）']);
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y) max(y)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13); 
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

%%
% >>> 自相关累积 <<<
% M 点自相关累积
M = 4;
y_cumu = zeros(1, length(y) - M);
for m = 1 : length(y) - M
    y_cumu(m) = 1 / M * dot(y(m + 1 : m + M), y(m : m + M - 1));
end

figure;
plot(t0(1 : length(y_cumu)), y_cumu, 'color', 'r', 'linewidth', 1);
title('y的自相关累积y_{cumu}');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y_cumu) max(y_cumu)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(-A^2, 4 * A^2, 6), 'fontsize', 13);
set(gca, 'yticklabel', {'-A^2', '0', 'A^2', '2A^2', '3A^2', '4A^2'});

%%
% >>> 分析lambda <<<
% 标准报头检测模板
n_half_us = fs / 2;
preambleTemp = [ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) zeros(1, 4 * n_half_us) ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) zeros(1, 6 * n_half_us)];

% 理想信号a lambda
K = 8 * fs;
R = zeros(1, length(a) - K + 1);
mu = zeros(1, length(a) - K + 1);
for m = 1 : length(a) - K + 1
    mu(m) = mean(a(m : m + K - 1));
    R(m) = 1 / K * preambleTemp * a(m : m + K - 1)';
end
lambda = R ./ mu;

figure;
plot(t0(1 : length(lambda)), lambda, 'color', 'k', 'linewidth', 1);
title('a的\lambda');
xlabel('Time(\mus)');
ylabel('\lambda');
axis([t0(1) t0(end) 0 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, 1, 5), 'fontsize', 13);

% 加噪信号y lambda
K = 8 * fs;
R = zeros(1, length(y) - K + 1);
mu = zeros(1, length(y) - K + 1);
for m = 1 : length(y) - K + 1
    mu(m) = mean(y(m : m + K - 1));
    R(m) = 1 / K * preambleTemp * y(m : m + K - 1)';
end
lambda = R ./ mu;

figure;
plot(t0(1 : length(lambda)), lambda, 'color', 'k', 'linewidth', 1);
title('y的\lambda');
xlabel('Time(\mus)');
ylabel('\lambda');
axis([t0(1) t0(end) 0 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, 1, 5), 'fontsize', 13);

% 自相关累积后的加噪信号的y_cumu lambda
K = 8 * fs;
R = zeros(1, length(y_cumu) - K + 1);
mu = zeros(1, length(y_cumu) - K + 1);
for m = 1 : length(y_cumu) - K + 1
    mu(m) = mean(y_cumu(m : m + K - 1));
    R(m) = 1 / K * preambleTemp * y_cumu(m : m + K - 1)';
end
lambda = R ./ mu;

figure;
plot(t0(1 : length(lambda)), lambda, 'color', 'k', 'linewidth', 1);
title('y_{cumu}的\lambda');
xlabel('Time(\mus)');
ylabel('\lambda');
axis([t0(1) t0(end) 0 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, 1, 5), 'fontsize', 13);