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

% >>> 加入高斯白噪声 <<<
% 测量信号功率
sigPower = 29 * A^2 / 60;
SNR = 1; % 比例形式
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(a));
y = a + noise;

y(y<0)=0; % 去除负值

figure;
stem(t0, y, 'color', 'k', 'linewidth', 1);
hold on;
plot(t0, abs(y), 'color', 'r', 'linewidth', 1);
legend('y', '|y|');
title(['加噪基带信号y和|y|（信噪比SNR=',num2str(SNR),'）']);
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y) max(y)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> 自相关累积 <<<
% M 点自相关累积
M = 13;
y_cumu = zeros(1, length(y) - M);
for m = 1 : length(y) - M
    y_cumu(m) = 1 / M * dot(y(m + 1 : m + M), y(m : m + M - 1));
end

figure;
stem(t0(1 : length(y_cumu)), y_cumu, 'color', 'k', 'linewidth', 1);
hold on;
plot(t0(1 : length(y_cumu)), abs(y_cumu), 'color', 'r', 'linewidth', 1);
legend('y_{cumu}', '|y_{cumu}|');
title('y的自相关累积y_{cumu}及|y_{cumu}|');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y_cumu) max(y_cumu)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(-A^2, 4 * A^2, 6), 'fontsize', 13);
set(gca, 'yticklabel', {'-A^2', '0', 'A^2', '2A^2', '3A^2', '4A^2'});

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

% 加噪信号|y| lambda
K = 8 * fs;
y_abs = abs(y);
R = zeros(1, length(y_abs) - K + 1);
mu = zeros(1, length(y_abs) - K + 1);
for m = 1 : length(y_abs) - K + 1
    mu(m) = mean(y_abs(m : m + K - 1));
    R(m) = 1 / K * preambleTemp * y_abs(m : m + K - 1)';
end
lambda = R ./ mu;

figure;
plot(t0(1 : length(lambda)), lambda, 'color', 'k', 'linewidth', 1);
title('|y|的\lambda');
xlabel('Time(\mus)');
ylabel('\lambda');
axis([t0(1) t0(end) 0 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, 1, 5), 'fontsize', 13);

% 自相关累积后的加噪信号的|y_cumu| lambda
K = 8 * fs;
y_cumu_abs = abs(y_cumu);
R = zeros(1, length(y_cumu_abs) - K + 1);
mu = zeros(1, length(y_cumu_abs) - K + 1);
for m = 1 : length(y_cumu_abs) - K + 1
    mu(m) = mean(y_cumu_abs(m : m + K - 1));
    R(m) = 1 / K * preambleTemp * y_cumu_abs(m : m + K - 1)';
end
lambda = R ./ mu;

figure;
plot(t0(1 : length(lambda)), lambda, 'color', 'k', 'linewidth', 1);
title('|y_{cumu}|的\lambda');
xlabel('Time(\mus)');
ylabel('\lambda');
axis([t0(1) t0(end) 0 1]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, 1, 5), 'fontsize', 13);

% % >>> 分析8微秒平均功率 <<<
% % 理想信号a 
% K = 8 * fs;
% power = zeros(1, length(a) - K + 1);
% for m = 1 : length(a) - K + 1
%     power(m) = 1 / K * sum( a(m : m + K - 1) .^ 2 );
% end
% 
% figure;
% plot(t0(1 : length(power)), power, 'color', 'k', 'linewidth', 1);
% title('a的8\mus平均功率');
% xlabel('Time(\mus)');
% ylabel('Power');
% axis([t0(1) t0(end) 0 A^2]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, A^2, 5), 'fontsize', 13);
% set(gca, 'yticklabel', {'0', '', 'A^2 / 2', '', 'A^2'});
% 
% % 加噪信号|y|
% K = 8 * fs;
% y_abs = abs(y);
% power = zeros(1, length(y_abs) - K + 1);
% for m = 1 : length(y_abs) - K + 1
%     power(m) = 1 / K * sum( y_abs(m : m + K - 1) .^ 2 );
% end
% 
% figure;
% plot(t0(1 : length(power)), power, 'color', 'k', 'linewidth', 1);
% title('|y|的8\mus平均功率');
% xlabel('Time(\mus)');
% ylabel('Power');
% axis([t0(1) t0(end) 0 (floor(max(power) / A^2) + 3) * A^2]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, (floor(max(power) / A^2) + 3) * A^2, 5), 'fontsize', 13);
% set(gca, 'yticklabel', {'0', '', [num2str((floor(max(power) / A^2) + 3) / 2 ),'A^2'], '', [num2str((floor(max(power) / A^2) + 3)),'A^2']});
% 
% % 自相关累积后的加噪信号的|y_cumu|
% K = 8 * fs;
% y_cumu_abs = abs(y_cumu);
% power = zeros(1, length(y_cumu_abs) - K + 1);
% for m = 1 : length(y_cumu_abs) - K + 1
%     power(m) = 1 / K * sum( y_cumu_abs(m : m + K - 1) .^ 2 );
% end
% 
% figure;
% plot(t0(1 : length(power)), power, 'color', 'k', 'linewidth', 1);
% title('|y_{cumu}|的8\mus平均功率');
% xlabel('Time(\mus)');
% ylabel('Power');
% axis([t0(1) t0(end) 0 (floor(max(power) / A^4) + 3) * A^4]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, (floor(max(power) / A^4) + 3) * A^4, 5), 'fontsize', 13);
% set(gca, 'yticklabel', {'0', '', [num2str((floor(max(power) / A^4) + 3) / 2 ),'A^4'], '', [num2str((floor(max(power) / A^4) + 3)),'A^4']});
% 
% % % >>> 分析瞬时功率 <<<
% % % 理想信号a
% % K = 8 * fs;
% % power = a .^ 2;
% % 
% % figure;
% % plot(t0(1 : length(power)), power, 'color', 'k', 'linewidth', 1);
% % title('a的瞬时功率');
% % xlabel('Time(\mus)');
% % ylabel('Power');
% % axis([t0(1) t0(end) 0 A^2]);
% % set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% % set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, A^2, 5), 'fontsize', 13);
% % set(gca, 'yticklabel', {'0', '', 'A^2 / 2', '', 'A^2'});
% % 
% % % 加噪信号|y|
% % K = 8 * fs;
% % y_abs = abs(y);
% % power = y_abs .^ 2;
% % 
% % figure;
% % plot(t0(1 : length(power)), power, 'color', 'k', 'linewidth', 1);
% % title('|y|的瞬时功率');
% % xlabel('Time(\mus)');
% % ylabel('Power');
% % axis([t0(1) t0(end) 0 (floor(max(power) / A^2) + 3) * A^2]);
% % set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% % set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, (floor(max(power) / A^2) + 3) * A^2, 5), 'fontsize', 13);
% % set(gca, 'yticklabel', {'0', '', [num2str((floor(max(power) / A^2) + 3) / 2 ),'A^2'], '', [num2str((floor(max(power) / A^2) + 3)),'A^2']});
% % 
% % % 自相关累积后的加噪信号的|y_cumu|
% % K = 8 * fs;
% % y_cumu_abs = abs(y_cumu);
% % power = y_cumu_abs .^ 2;
% % 
% % figure;
% % plot(t0(1 : length(power)), power, 'color', 'k', 'linewidth', 1);
% % title('|y_{cumu}|的瞬时功率');
% % xlabel('Time(\mus)');
% % ylabel('Power');
% % axis([t0(1) t0(end) 0 (floor(max(power) / A^4) + 3) * A^4]);
% % set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% % set(gca, 'box', 'off', 'xtick', linspace(0, 120, 16), 'ytick', linspace(0, (floor(max(power) / A^4) + 3) * A^4, 5), 'fontsize', 13);
% % set(gca, 'yticklabel', {'0', '', [num2str((floor(max(power) / A^4) + 3) / 2 ),'A^4'], '', [num2str((floor(max(power) / A^4) + 3)),'A^4']});
