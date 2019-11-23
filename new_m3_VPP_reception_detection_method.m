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

SNR = 10; % 信噪比，dB形式(分别取10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
sigma = sqrt(alpha^2 / SNR); % 噪声标准差

e = wgn(1, length(p), sigma^2, 'linear');
% e = raylrnd(sigma, 1, length(p));

% 视频信号
sd = alpha * m + e;

% --- 取对数视频信号
sd = 10*log10(abs(sd)*1000);
figure;
hold;
plot(sd); % 单位：dBm

% --- 设置threshold (没有用)
thres = 31; % 单位：dBm
plot([0 length(sd)], [thres thres], '-.');
% mrl = -88 + 4; % 单位：dBm

plot(10*log10(abs(alpha * p)*1000), '.');

% --- 提取VPP和LE，判定4脉冲位置，确定是否为preamble
NC = 6;
VPP = zeros(1, length(sd) - NC);
LE = zeros(1, length(sd) - NC);
for i = 1 : length(sd) - NC
    if (sd(i)>thres)&&(sd(i+1)>thres)&&(sd(i+2)>thres)&&(sd(i+3)>thres)&&(sd(i+4)>thres)&&(sd(i+5)>thres)&&(sd(i+6)>thres)
        VPP(i) = 1;
        if (sd(i) - sd(i-1)) > 2.18 % 上升沿判定（2.18dB = 48dB/22）
            LE(i) = 2;
        end
    end
end
figure;
hold on;
stem(VPP);
stem(LE);
axis([0 length(VPP) 0 3]);
% 1761 1783 1838 1860
if (LE(1761-2)==2) || (LE(1761-1)==2) || (LE(1761)==2) || (LE(1761+1)==2) || (LE(1761+2)==2)
    if (LE(1783-2)==2) || (LE(1783-1)==2) || (LE(1783)==2) || (LE(1783+1)==2) || (LE(1783+2)==2)
        if (LE(1838-2)==2) || (LE(1838-1)==2) || (LE(1838)==2) || (LE(1838+1)==2) || (LE(1838+2)==2)
            if (LE(1860-2)==2) || (LE(1860-1)==2) || (LE(1860)==2) || (LE(1860+1)==2) || (LE(1860+2)==2)
                disp('yes');
            end
        end
    end
end

% if (LE(1761)==2) && (LE(1783)==2) && (LE(1838)==2) && (LE(1860)==2)
%     disp('pass');
% else
%     disp('no');
% end




