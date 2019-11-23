% VPP(有效脉冲位置)检测算法模拟

clear, clc;
close all;

% --- 生成基带信号

fs = 22; % 采样率，单位：MHz
Tb = 1; % 码元宽度，单位：us
t0 = -80 : 1/fs : 200; % 时间序列，单位：us
b = @(t, d)d * rect(t) + (1-d) * rect(t-Tb/2.0); % 脉冲位置调制码元

% 报头
% p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 2, 1) + b(t0 - 3, 0) + b(t0 - 4, 0) + b(t0 - 5, 1) + b(t0 - 6, 1) + b(t0 - 7, 1);
p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 3, 0) + b(t0 - 4, 0);

% 基带信号
m = p;

% 接收信号
alpha = 2; % 接收信号电平

M = 8 * fs; % 8us 所对应的采样点数

SNR = 15; % 信噪比，dB形式(分别取10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
sigma = sqrt(alpha^2 / SNR); % 噪声标准差

% 0.1572 0.1337 0.1109 0.0894 0.0697 0.0522 0.0374 0.0254 0.0162 0.0096
% 0.0053 0.0027 0.0014 7.9617e-4 6.1862e-4 6.0936e-4 6.7405e-4 7.5449e-4
% 8.3718e-4 9.0326e-4 9.5197e-4 9.6724e-4 9.622e-4 9.3810e-4

% 循环起始点
cycletime = 20000;
passtime = 0; % 通过的次数
pd = 0;
pfa = 0; % 虚警概率
for k = 1 : cycletime
    
    % 生成噪声
    e = wgn(1, length(p), sigma^2, 'linear');
    % e = raylrnd(sigma, 1, length(p));

    % 生成视频信号
    sd = (alpha * m + e).^2; % 单位：W

    % 取对数视频信号
    sd_log = 10*log10(abs(sd)*1000); % 单位：dBm

    % --- 设置threshold，是否应该向下取6dB(对于功率)？
    thres = 10*log10((alpha)^2*1000) - 6;
    % thres = 10*log10((alpha+sqrt(pi/2)*sigma)^2*1000) - 6; % 单位：dBm
    
    % --- 将thres以下的信号丢弃
    sd_log(sd_log<thres) = thres;
    
    % --- 提取VPP和LE，判定4脉冲位置，确定是否为preamble
    NC = 6; % 采样率22M对应的VPP连续采样点数
    VPP = zeros(1, length(sd) - NC); % 记录VPP的位置
    LE = zeros(1, length(sd) - NC); % 记录LE的位置
    for i = 3 : length(sd) - NC % 1761-3 : 1860+3 % 为节省计算时间，缩短计算范围
        if (sd_log(i)>thres)&&(sd_log(i+1)>thres)&&(sd_log(i+2)>thres)&&...
            (sd_log(i+3)>thres)&&(sd_log(i+4)>thres)&&(sd_log(i+5)>thres)&&(sd_log(i+6)>thres)
            VPP(i) = 1;
            if (sd(i) - sd(i-1)) > 2.18 % 判定该VPP是否为LE（2.18dB = 48dB/22）
                LE(i) = 2;
            end
        end
    end
    
%     % 准确的上升沿位置：1761 1783 1838 1860
%     n_LE = 0; % 4个VPP中上升沿的数量，容错采样点位置为前后各2
%     if (LE(1761-2)==2) || (LE(1761-1)==2) || (LE(1761)==2) || (LE(1761+1)==2) || (LE(1761+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if (LE(1783-2)==2) || (LE(1783-1)==2) || (LE(1783)==2) || (LE(1783+1)==2) || (LE(1783+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if (LE(1838-2)==2) || (LE(1838-1)==2) || (LE(1838)==2) || (LE(1838+1)==2) || (LE(1838+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if (LE(1860-2)==2) || (LE(1860-1)==2) || (LE(1860)==2) || (LE(1860+1)==2) || (LE(1860+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if n_LE >= 2
%         passtime = passtime + 1;
%     end 
    
    n_LE = 0; % 4个VPP中上升沿的数量，容错采样点位置为前后各1
    if (LE(1761-1)==2) || (LE(1761)==2) || (LE(1761+1)==2)
        n_LE = n_LE + 1;
    end
    if (LE(1783-1)==2) || (LE(1783)==2) || (LE(1783+1)==2)
        n_LE = n_LE + 1;
    end
    if (LE(1838-1)==2) || (LE(1838)==2) || (LE(1838+1)==2)
        n_LE = n_LE + 1;
    end
    if (LE(1860-1)==2) || (LE(1860)==2) || (LE(1860+1)==2)
        n_LE = n_LE + 1;
    end
    if n_LE >= 2
        passtime = passtime + 1;
    end 
    
    pfa = pfa + length(LE(LE>0))/length(LE);
    
end

passtime
pd = passtime / cycletime
pfa = pfa / cycletime

figure;
hold;
plot(sd_log);
plot([0 length(sd_log)], [thres thres], '-.');
plot(10*log10(abs(alpha^2 * p)*1000), '.');

figure;
hold on;
stem(VPP);
stem(LE);
axis([0 length(VPP) 0 3]);



