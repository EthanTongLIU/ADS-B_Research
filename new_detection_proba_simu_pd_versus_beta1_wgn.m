%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 仿真检测概率
% 噪声模型直接采用瑞利分布

% 1. pd versus beta1 at different SNR

format long;
clear, clc;
close all;

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

% -----> 外层循环(信噪比)
SNR = 10; % 信噪比，dB形式(分别取10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
sigma = sqrt(alpha^2 / SNR); % 噪声标准差

% -----> 内层循环(beta1)
beta1 = 69; % beta1(分别取20 40 60 80 100 120 140 160)

passtime = 0; % 检测到报头的次数记录
for cycletime = 1 : 20000 % 重复进行蒙特卡洛仿真实验
    
    e = normrnd(0, sigma, 1, length(p)); 
    sd = alpha * m + e;
    
    % 数据存储矩阵
    sc = zeros(1, length(p) - M + 1);
    me = zeros(1, length(p) - M + 1);
    
    for i = 1760:1761
        me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+11-1), sd(i+77:i+77+11-1), sd(i+99:i+99+11-1)])); % 噪声包络均值
        sc(i) = pd * sd(i : i+M-1)'; % 滑动求和结果
        if (sc(i) / me(i) > beta1)
            if i == 1761
                passtime = passtime + 1;
                break;
            end
        end
    end
    
end

passtime








