% 虚警概率与检测门限的关系

format long;
clear, clc;
close all;

figure;

r1 = 44; % 选定采样率为 22M

beta1 = linspace(10, 70, 1000);
Pfa = 1 - normcdf(sqrt(2/pi)/sqrt(r1)*beta1);

semilogy(beta1, Pfa, 'color', 'b', 'linewidth', 1.3);

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{fa}$', 'interpreter', 'latex');
grid on;