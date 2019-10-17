% 苏老师修改后的版本的检测概率

format long;
clear, clc;
close all;

% 理论检测概率

%% 1. 固定 r1，beta1 作为横轴

figure;
hold on;

r1 = 44; % 样本数，选定采样率为 22M

SNR = 0.1;
beta1 = linspace(0, 140, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', [0 0 1]);

SNR = 0.5;
beta1 = linspace(0, 140, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', [1 0 0]);

SNR = 1;
beta1 = linspace(0, 140, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', [1 0.65 0]);

SNR = 3;
beta1 = linspace(0, 140, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', 'm');

SNR = 10;
beta1 = linspace(0, 140, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', 'g');

xlabel('Threshold \beta_{1}');
ylabel('P_{d}');
grid on;

%% 2. 固定r1，SNR 作为横轴

figure;
hold on;
xlabel('SNR');
ylabel('P_{d}');

r1 = 30; % 样本数

for beta1 = 20 : 10 : 60 % 检测门限
    SNR = linspace(0.1, 20, 100); % 信噪比，原始比例形式
    Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(SNR, Pd, 'color', 'r');
end

%% 3. 固定 beta1，r1 作为横轴

figure;
hold on;
xlabel('r1');
ylabel('P_{d}');

beta1 = 60; % 检测门限

for SNR = 1 : 2 : 10
    r1 = linspace(10, 200, 200); % 采样点数
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(r1, Pd, 'color', 'r');
end

%% 4. 固定 beta1，SNR 作为横轴

figure;
hold on;
xlabel('SNR');
ylabel('P_{d}');

beta1 = 50; % 检测门限

for r1 = 10 : 50 : 200
    SNR = linspace(0.1, 20, 100); % 采样点数
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(SNR, Pd, 'color', 'r');
end

%% 5. 固定 SNR，beta1 作为横轴

figure;
hold on;
xlabel('beta1');
ylabel('P_{d}');

SNR = 0.5; % 信噪比，原始比例形式

for r1 = 10 : 20 : 100
    beta1 = linspace(0.1, 70, 100); % 采样点数
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(beta1, Pd, 'color', 'r');
end

%% 6. 固定 SNR，r1 作为横轴

figure;
hold on;
xlabel('r1');
ylabel('P_{d}');

SNR = 1; % 信噪比，原始比例形式

for beta1 = 10 : 10 : 70
    r1 = linspace(10, 200, 100); % 采样点数
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(r1, Pd, 'color', 'r');
end

% 仿真检测概率

% 绘制 Pfa 与 Pd 之关系

















