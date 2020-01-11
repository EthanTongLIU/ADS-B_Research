%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 仿真检测概率
% pd versus beta1 at different SNR

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
SNR = 5; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
sigma = sqrt(alpha^2 / SNR); % 噪声标准差

% -----> 内层循环(beta1)
Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % 检测门限

passtime = 0; % 检测到报头的次数记录
for cycletime = 1 : 1 % 重复进行蒙特卡洛仿真实验
    
    % 以下两种噪声定义形式相同，都采用纯高斯白噪声
    % e = normrnd(0, sigma, 1, length(p));
    e = wgn(1, length(p), sigma^2, 'linear');
    
    % 以下噪声产生一个瑞利分布的包络
    % e = raylrnd(sigma, 1, length(p));
    
    % 以下噪声产生一个瑞利分布的包络，相邻取反，违背了时刻不相关性的原则
    % e = raylrnd(sigma, 1, length(p));
    % e(2:2:end) = -e(2:2:end);
    
    % 以下噪声将瑞利分布的包络按时刻的不相关性取正负，构造成零均值的噪声
    % e = raylrnd(sigma, 1, length(p));
    % coef = (fix(rand(1,length(e))*2)-0.5)*2;
    % e = coef.*e;
   
    % 信号序列
    sd = alpha * m;
    % sd = alpha * m + e;
    
    % 数据存储矩阵
    sc = zeros(1, length(p) - M + 1);
    me = zeros(1, length(p) - M + 1);
    cfardata = zeros(1, length(p) - M + 1);
    
    % 单次检验性质
    for i = 1 : length(sd) - M + 1
        me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+44-1), sd(i+88:i+88+11-1), sd(i+110:i+110+66-1)])); % 噪声包络均值
        sc(i) = pd * sd(i:i+M-1)'; % 滑动求和结果
        if (sc(i) / me(i) > beta1)
            cfardata(i) = sc(i) / me(i);
        end
    end
    
%     % 多次统计检测率
%     for i = 1761
%         me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+44-1), sd(i+88:i+88+11-1), sd(i+110:i+110+66-1)])); % 噪声包络均值
%         sc(i) = pd * sd(i:i+M-1)'; % 滑动求和结果
%         if (sc(i) / me(i) > beta1)
%             if (i == 1761)
%                 passtime = passtime + 1;
%                 break;
%             end
%         end
%     end
    
end

% 单次检验性质
figure;
subplot(411);
plot(e);title('e');
subplot(412);
plot(sc);title('sc');
subplot(413);
plot(me);title('me');
subplot(414);
plot(cfardata);title('cfardata');
[maxcfardata, tag] = max(cfardata)

% 画一个相关峰
figure;
scc = sc(1651:1871)/max(sc);
plot(1:length(scc), scc, 'color', 'k');
axis([1 length(scc) 0 1]);

set(gcf, 'units', 'centimeters', 'Position', [12 12 6 4]);%设置图片大小为 6cm×6cm
xlabel('t$({\rm \mu s})$', 'interpreter', 'latex');
ylabel('$s_{c}$', 'interpreter', 'latex');

set(gca, 'xtick', [12 34 56 89 111 133 166 188 210]); 
set(gca, 'xticklabel', [-4.5 -3.5 -2.5 -1 0 1 2.5 3.5 4.5]); 

set(get(gca, 'xlabel'), 'fontsize', 7, 'fontname', 'euclid'); % 坐标轴标签
set(get(gca, 'ylabel'), 'fontsize', 7, 'fontname', 'euclid'); % 坐标轴标签
set(gca, 'fontsize', 7, 'fontname', 'euclid'); % 坐标轴
set(gca, 'linewidth', 0.5); % 坐标轴线粗0.5磅
set(gca, 'box', 'on');
set(get(gca,'Children'), 'linewidth', 0.5); %设置图中线宽0.5磅
grid on;
set(gca, 'gridlinestyle', ':', 'GridColor', 'k', 'gridalpha', 1);


% % 多次统计检测率
% passtime
% pd = passtime/20000








