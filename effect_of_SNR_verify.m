clear, clc;
close all;

fs = 22; % MHz 采样频率，应大于 2 * 1090
Tb = 1; % us
t0 = -20 : 1/fs : 140;
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
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 31), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> 加入高斯白噪声 <<<
% 测量信号功率
sigPower = 29 * A^2 / 60;
SNR = 1; % 比例形式
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(a));
y = a + noise;

figure;
stem(t0, y, 'color', 'k', 'linewidth', 1);
hold on;
stem(t0, abs(y), 'color', 'r', 'linewidth', 1);
legend('y', '|y|');
title(['加噪基带信号y和|y|（信噪比SNR=',num2str(SNR),'）']);
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y) max(y)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 31), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> 自相关累积 <<<
% M 点自相关累积
M = 4;
y_cumu = zeros(1, length(y) - M);
for m = 1 : length(y) - M
    y_cumu(m) = 1 / M * dot(y(m + 1 : m + M), y(m : m + M - 1));
end

figure;
stem(t0(1 : length(y_cumu)), y_cumu, 'color', 'k', 'linewidth', 1);
hold on;
stem(t0(1 : length(y_cumu)), abs(y_cumu), 'color', 'r', 'linewidth', 1);
legend('y_{cumu}', '|y_{cumu}|');
title('y的自相关累积y_{cumu}及|y_{cumu}|');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y_cumu) max(y_cumu)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 31), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> 报头检测门限动态指标（电平指标）<<<
% 标准报头检测模板
preambleTemp = [ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 44) ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 66)];

adsbStd = a(441 : 3080);
ra1 = dot(preambleTemp, adsbStd(1 : 176)) / mean(adsbStd(1 : 176));
disp(['理想模型报头卷积与均值之比（理论）： ', num2str(ra1)]);

ra2 = zeros(2, 2464);
for i = 176 : 2464
    sig = adsbStd(i + 1 : i + 176); 
    ra2(1, i) = dot(preambleTemp, sig) / mean(sig);
end
disp(['理想模型信号段除报头段卷积与均值之比（理论，统计平均）： ', num2str(mean(ra2(1, :)))]);

% 加噪信号（改变SNR）
adsbReal = y(441 : 3080);
ra1n = dot(preambleTemp, adsbReal(1 : 176)) / mean(adsbReal(1 : 176));
disp(['加噪模型报头卷积与均值之比（加噪，样本数量1）： ', num2str(ra1n)]);

for i = 176 : 2464
    sig = adsbReal(i + 1 : i + 176); 
    ra2(2, i) = dot(preambleTemp, sig) / mean(sig);
end
disp(['加噪模型信号段除报头段卷积与均值之比（加噪，统计平均）： ', num2str(mean(ra2(2, :)))]);

figure;
hold on;
plot(1:length(ra2(1,:)) , ra2(1,:), 'color', 'r');
plot([1, length(ra2(1,:))], [mean(ra2(1,:)), mean(ra2(1,:))], 'color', 'g');
plot(1:length(ra2(2,:)) , ra2(2,:), 'color', 'b');
plot([1, length(ra2(2,:))], [mean(ra2(2,:)), mean(ra2(2,:))], 'color', 'm');
legend('理想信号', '理想均值', '有噪信号', '有噪均值');
title('信号内非报头段倍数分析（理想+有噪）');
xlabel('点数');
ylabel('倍数');
axis([1 length(ra2(1,:)) 0 100]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 1 : 500 : length(ra2(1,:)), 'ytick', 0 : 20 : 100, 'fontsize', 13);

% 纯噪声统计特性
noiseSeq = abs([y(1 : 440), y(3081 : 3521)]);
ra3 = zeros(1, length(noiseSeq) - 176);
for i = 1 : length(noiseSeq) - 176
    ra3(i) = dot(preambleTemp, noiseSeq(i + 1 : i + 176)) / mean(noiseSeq(i + 1 : i + 176));
end

disp(['噪声倍数（统计平均）： ', num2str(mean(ra3))]);

figure;
plot(1:length(ra3) , ra3);
hold on;
plot([1, length(ra3)], [mean(ra3), mean(ra3)]);
title('纯噪声倍数分析');
xlabel('点数');
ylabel('倍数');
axis([1 length(ra3) 20 70]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 1 : 100 : length(ra3), 'ytick', 20 : 5 : 70, 'fontsize', 13);

disp(['噪声对检测门限的影响（降低倍数）：', num2str(ra1 / ra1n)]);

% >>> 报头检测门限动态指标（功率指标） <<<

disp(' ');

% preambleTemp = A * preambleTemp;

% 理想信号
preamblePower = sum(adsbStd(1 : 176) .^ 2) / 176;
ra1 = dot(preambleTemp, adsbStd(1 : 176)) / preamblePower;
disp(['理想模型报头卷积与均值之比（理论）： ', num2str(ra1)]);

ra2 = zeros(2, 2464);
for i = 176 : 2464
    sig = adsbStd(i + 1 : i + 176); 
    ra2(1, i) = dot(preambleTemp, sig) / (sum(sig .^ 2) / 176);
end
disp(['理想模型信号段除报头段卷积与均值之比（理论，统计平均）： ', num2str(mean(ra2(1, :)))]);

% 加噪信号（改变SNR）
preamblePower = sum(adsbReal(1 : 176) .^ 2) / 176;
ra1n = dot(preambleTemp, adsbReal(1 : 176)) / preamblePower;
disp(['加噪模型报头卷积与均值之比（加噪，样本数量1）： ', num2str(ra1n)]);

for i = 176 : 2464
    sig = adsbReal(i + 1 : i + 176); 
    ra2(2, i) = dot(preambleTemp, sig) / (sum(sig .^ 2) / 176);
end
disp(['加噪模型信号段除报头段卷积与均值之比（加噪，统计平均）： ', num2str(mean(ra2(2, :)))]);

% 纯噪声
noiseSeq = abs([y(1 : 440), y(3081 : 3521)]);
ra3 = zeros(1, length(noiseSeq) - 176);
for i = 1 : length(noiseSeq) - 176
    noisePower = sum(noiseSeq(i + 1 : i + 176) .^ 2) / 176;
    ra3(i) = dot(preambleTemp, noiseSeq(i + 1 : i + 176)) / noisePower;
end
disp(['噪声倍数（统计平均）： ', num2str(mean(ra3))]);

disp(['噪声对检测门限的影响（降低倍数）：', num2str(ra1 / ra1n)]);

disp(' ');
disp(['噪声平均功率：', num2str(sum(noiseSeq .^ 2) / length(noiseSeq)), 'W']);
disp(['报头平均功率：', num2str(preamblePower), 'W']);

power = zeros(1, length(y) - 176);
for i = 1 : length(y) - 175
    power(i) = sum(y(i : i + 176 - 1) .^ 2) / 176;
end
figure;
plot(power);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);





