% 苏老师修改后的版本的检测概率

format long;

% 理论检测概率

%% 1. 固定 r1，beta1 作为横轴

clear, clc;
close all;

figure;
hold on;

r1 = 44; % 样本数，选定采样率为 22M

SNR = -10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = linspace(0, 170, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = -3; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = linspace(0, 170, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 0; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = linspace(0, 170, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 3; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = linspace(0, 170, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = linspace(0, 170, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('-10 (理论值)', '  -3 (理论值)', '   0 (理论值)', '   3 (理论值)', ' 10 (理论值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');
xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;

%% 2. 固定r1，SNR 作为横轴

clear, clc;
close all;

figure;
hold on;

r1 = 44; % 样本数，采样率为 22M

SNR = linspace(0.1, 20, 1000); % 信噪比，原始比例形式

beta1 = 20; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 30; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = linspace(0.1, 20, 200); % 信噪比，原始比例形式

beta1 = 40; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

beta1 = 50; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

beta1 = 60; % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('20 (理论值)', '30 (理论值)', '40 (理论值)', '50 (理论值)', '60 (理论值)');
title(leg, '\beta_{1}');
xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;

%% 3. 固定r1，Pfa 作为横轴

clear, clc;
close all;

figure;
hold on;

r1 = 44; % 样本数，采样率为 22M

Pfa = linspace(1e-9, 1e-3, 100000);

SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

Pfa = linspace(1e-9, 1e-3, 50000);

SNR = 5.5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 6; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 6.5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('    5 (理论值)', ' 5.5 (理论值)', '    6 (理论值)', ' 6.5 (理论值)', '  10 (理论值)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');
xlabel('$P_{fa}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');

set(gca, 'xtick', [-9 -8 -7 -6 -5 -4 -3], 'xticklabel', {'1e-9', '1e-8', '1e-7', '1e-6', '1e-5', '1e-4', '1e-3'});

grid on;


% 仿真检测概率

%% 1. pd versus beta1 at different SNR

format long;

fs = 22; % 采样率，单位：MHz
r1 = 44;
Tb = 1; % 码元宽度，单位：us
t0 = -80 : 1/fs : 200; % 时间序列，单位：us
b = @(t, d)d * rect(t) + (1-d) * rect(t-Tb/2.0); % 脉冲位置调制码元

% 报头
p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 3, 0) + b(t0 - 4, 0);

% 基带信号
m = p;

% 本地报头
n_half_us = fs / 2;
pd = [ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) ...
    zeros(1, 4 * n_half_us) ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) zeros(1, 6 * n_half_us)];

% 接收信号
alpha = 2; % 接收信号电平

M = 8 * fs; % 8us 所对应的采样点数

% 数据存储矩阵
sc = zeros(1, length(sd) - M + 1);
me = zeros(1, length(sd) - M + 1);
cfardata = zeros(1, length(sd) - M + 1);

%% 1. SNR = 10
SNR = 10; % 信噪比，原始比例形式
sigma = sqrt(alpha^2 / SNR); % 噪声标准差
e = normrnd(0, sigma, 1, length(p));
sd = alpha * m + e;

Pfa = 1e-6; % 虚警概率
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa) + r1; % 检测门限

fndnum = 0;
for m = 1 : length(sd) - M + 1
    me(m) = mean(abs([sd(m+11:m+11+11-1), sd(m+33:m+33+11-1), sd(m+77:m+77+11-1), sd(m+99:m+99+11-1)])); % 噪声包络均值
    sc(m) = abs(pd * sd(m : m+M-1)');
    if (sc(m) / me(m) > beta1)
        cfardata(m) = sc(m) / me(m);
        fndnum = fndnum + 1;
        if m == 1761
            break;
        end
    end
end

plot(cfardata);
title(num2str(fndnum));


















