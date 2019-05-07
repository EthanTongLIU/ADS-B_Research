clear, clc;
close all;

% 验证相关性，自相关累积等

fs = 22; % MHz 采样频率，应大于 2 * 2 * 1090
Tb = 1; % us
t0 = -20 : 1/fs : 140;
b = @(t, d)d * rect(t) + (1 - d) * rect(t - Tb / 2.0);

scrsz = get(0,'ScreenSize'); % 获取屏幕尺寸

% >>> 构建报头 <<<
h = rect(t0) + rect(t0 - 1) + rect(t0 - 3.5) + rect(t0 - 4.5);

figure;
plot(t0, h, 'color', 'k', 'linewidth', 1.5);
title('报头段');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

% >>> 构建数据报文 <<<
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

% >>> 合成基带信号 <<<
a = h + d;

% >>> 报头的自相关特征 <<<
p = h(441 : 441 + 175);
r = xcorr(p, p) / length(p);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
title('报头的自相关特征');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(r), max(r), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 报头的自相关特征（添加噪声） <<<
sigPower = sum(abs(p) .^ 2) / length(p);
SNR = 0.1; % 比例形式
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(p));

p = p + noise;
r = xcorr(p, p) / length(p);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
title('报头的自相关特征（添加噪声）');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(r), max(r), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 报头的自相关特征（添加噪声 + 自相关累积） <<<
p_cumu = zeros(1, length(p) - 3);
for i = 2 : length(p) - 3
    p_cumu(i) = 1 / 4 * p(i : i + 3) * p(i - 1 : i + 2)';
end

r = xcorr(p_cumu, p_cumu) / length(p_cumu);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
title('报头的自相关特征（添加噪声 + 自相关累积）');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(r), max(r), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 互相关检测 <<<
preamble_temp = [ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 44) ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 66)];

s = length(a);
m = length(preamble_temp);
R = zeros(1, s - m + 1);

for i = 1 : s - m + 1
    R(i) = preamble_temp * a(i : i + m - 1)';
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('互相关检测');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 倍数检测 <<<
for i = 1 : s - m + 1
    mean_current = mean(a(i : i + m - 1));
    R(i) = preamble_temp * a(i : i + m - 1)' / mean_current;
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('倍数检测');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 互相关检测（添加噪声） <<<
sigPower = sum(abs(a) .^ 2) / length(a);
SNR = 0.1; % 比例形式
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(a));

a = abs(a + noise);

for i = 1 : s - m + 1
    R(i) = preamble_temp * a(i : i + m - 1)';
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('互相关检测（添加噪声）');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 倍数检测（添加噪声） <<<

for i = 1 : s - m + 1
    mean_current = mean(a(i : i + m - 1));
    R(i) = preamble_temp * a(i : i + m - 1)' / mean_current;
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('倍数检测（添加噪声）');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> 倍数检测（添加噪声 + 自相关累积） <<<
a_cumu = zeros(1, length(a) - 3);
for i = 2 : length(a_cumu) - 3
    a_cumu(i) = 1 / 4 * a(i : i + 3) * a(i - 1 : i + 2)';
end

a_cumu = abs(a_cumu);

for i = 1 : length(a_cumu) - m + 1
    mean_current = mean(a_cumu(i : i + m - 1));
    R(i) = preamble_temp * a_cumu(i : i + m - 1)' / mean_current;
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('倍数检测（添加噪声 + 自相关累积）');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);