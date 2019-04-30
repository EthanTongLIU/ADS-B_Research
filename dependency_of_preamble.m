clear, clc;
close all;

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

p = h(441 : 441 + 175);
r = xcorr(p, p) / length(p);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
% title('自相关');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(r), max(r), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

sigPower = sum(abs(p) .^ 2) / length(p);
SNR = 0.5; % 比例形式
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(p));

p = p + noise;
r = xcorr(p, p) / length(p);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
% title('自相关');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(r), max(r), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);