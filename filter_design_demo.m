clear, clc;
close all;

% 滤波器长度
N = 41;
% 采样频率，单位：Hz
fs = 2000;

% 低通滤波器截止频率，单位：Hz
fc_lpf = 200;

% 以采样频率为标准，对频率归一化
wn_lpf = fc_lpf*2/fs;

% 采用fir1函数设计FIR滤波器
b_lpf = fir1(N-1, wn_lpf);

% 求幅频响应
m_lpf = 20*log(abs(fft(b_lpf)))/log(10);

% 设置频率响应的横坐标单位为Hz
x_f = 0:(fs/length(m_lpf)):fs/2;

% 单位脉冲响应
figure;
stem(b_lpf);
xlabel('n');
ylabel('h(n)');

% 幅频响应
figure;
plot(x_f, m_lpf(1:length(x_f)));
xlabel('频率(Hz)');
ylabel('幅度(dB)');

% 对某一原始数据xx进行滤波，得到数据yy
L = 1500;
t = (0:L-1)*1/fs;
xx = 0.7*sin(2*pi*60*t) + sin(2*pi*140*t) + randn(size(t));

figure;
plot(1000*t, xx);
xlabel('t/ms');
ylabel('magnitude');

yy = fft(xx);     % 求解傅里叶变换
P2 = abs(yy/L);   % 双侧频谱
% P1 = P2(1:L/2+1); % 计算单侧信号频谱
% P1(2:end-1) = 2*P1(2:end-1);

f = fs/L*(0:L-1);

% f = fs * (0:(L/2))/L;
figure;
plot(f, P2);
xlabel('f(Hz)');
ylabel('|P1(f)|');

%%
zz = filter(b_lpf, 1, xx);

figure;
plot(1000*t, zz);
xlabel('t/ms');
ylabel('magnitude');

uu = fft(zz);
P2 = abs(uu/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure;
plot(f, P1);
xlabel('f(Hz)');
ylabel('|P1(f)|');