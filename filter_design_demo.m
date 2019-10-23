clear, clc;
close all;

%% 设计 FIR 低通滤波器
% 滤波器长度
N = 161;
% 采样频率，单位：Hz
fs = 2000;
% 低通滤波器截止频率，单位：Hz
fc_lpf = 200;
% 以采样频率为标准，对频率归一化
wn_lpf = fc_lpf*2/fs;
% 采用fir1函数设计FIR滤波器
b_lpf = fir1(N-1, wn_lpf);
% 求幅频响应
m_lpf = 20*log10(abs(fft(b_lpf)));
% 设置频率响应的横坐标单位为Hz
x_f = 0:(fs/length(m_lpf)):fs/2;

% 滤波器单位脉冲响应
figure;
subplot(121);
stem(b_lpf);
xlabel('n');
ylabel('h(n)');
title('低通滤波器单位冲激响应');

% 滤波器幅频响应
subplot(122);
plot(x_f, m_lpf(1:length(x_f)));
xlabel('频率(Hz)');
ylabel('幅度(dB)');
title('低通滤波器幅频响应');

%% 设计原始数据信号xx
L = 1500; % 信号长度
t = (0:L-1)*1/fs; % 时间
xx = 0.7*sin(2*pi*60*t) + sin(2*pi*140*t) + randn(size(t)); % 信号

figure;
subplot(121);
plot(1000*t, xx);
xlabel('t/ms');
ylabel('xx(t)');
title('xx');

XX = fft(xx);     % 求解傅里叶变换
P2 = abs(XX/L);   % 双侧频谱
% P1 = P2(1:L/2+1); % 计算单侧信号频谱
% P1(2:end-1) = 2*P1(2:end-1);

f = fs/L*(0:L-1); % 横轴

% f = fs * (0:(L/2))/L;
subplot(122);
plot(f(1:L/2), P2(1:L/2));
xlabel('f(Hz)');
ylabel('幅度');
title('xx的频谱XX');

%% 对xx进行滤波，得到yy
yy = filter(b_lpf, 1, xx);

figure;
subplot(121);
plot(1000*t, yy);
xlabel('t/ms');
ylabel('yy(t)');

YY = fft(yy);
P2 = abs(YY/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);

subplot(122);
plot(f(1:L/2), P2(1:L/2));
xlabel('f(Hz)');
ylabel('幅度');
title('yy的频谱YY');