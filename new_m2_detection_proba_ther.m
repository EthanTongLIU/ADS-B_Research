% 简化的模型，非包络检波条件下的检测率情况模拟

format long;

% 1. 固定 r1，beta1 作为横轴

clear, clc;
close all;

figure;
hold on;

r1 = 44; % 样本数，选定采样率为22M

SNR = 10; % 信噪比，dB形式
SNR = power(10, SNR / 10); % 信噪比，原始比例形式
beta1 = linspace(0, 170, 100); % 检测门限
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

grid on;