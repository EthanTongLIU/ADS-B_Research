%% 虚警概率与检测门限的关系

format long;
clear, clc;
close all;

figure;
% 理论虚警率

r1 = 44; % 选定采样率为 22M

beta1 = linspace(35, 65, 1000);
Pfa = 1 - normcdf((beta1 - r1)/sqrt(r1*(4-pi)/pi));

% Pfa = linspace(10e-1, 10e-10, 1000);
% beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;

semilogy(beta1, Pfa, 'color', 'b');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{fa}$', 'interpreter', 'latex');

grid on;

% 仿真虚警率