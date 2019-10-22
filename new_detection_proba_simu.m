%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 仿真检测概率

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
SNR = 5; % 信噪比，原始比例形式(分别取10, 6.5, 6, 5.5, 5)
sigma = sqrt(alpha^2 / SNR); % 噪声标准差

% -----> 内层循环(虚警概率)
Pfa = 1e-9; % 虚警概率(分别取虚警概率1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9)
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa) + r1; % 检测门限

passtime = 0; % 检测到报头的次数记录
for cycletime = 1 : 10000 % 重复进行蒙特卡洛仿真实验

    e = normrnd(0, sigma, 1, length(p)); % 每次重新构造噪声
    sd = alpha * m + e; 

    % 数据存储矩阵
    sc = zeros(1, length(p) - M + 1);
    me = zeros(1, length(p) - M + 1);
    cfardata = zeros(1, length(p) - M + 1);

    % fndnum = 0; % 每次找到的报头数目
  % for i = 1 : length(sd) - M + 1
    for i = 1760 : 1761
        me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+11-1), sd(i+77:i+77+11-1), sd(i+99:i+99+11-1)])); % 噪声包络均值
        sc(i) = abs(pd * sd(i : i+M-1)'); % 滑动求和结果
        if (sc(i) / me(i) > beta1)
            % cfardata(i) = sc(i) / me(i);
            % fndnum = fndnum + 1;
            if i == 1761
                passtime = passtime + 1;
                break;
            end
        end
    end
    
end

passtime

% plot(cfardata);
% title(num2str(fndnum));