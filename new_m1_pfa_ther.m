%% �龯�����������޵Ĺ�ϵ

format long;
clear, clc;
close all;

figure;
% �����龯��

r1 = 44; % ѡ��������Ϊ 22M

beta1 = linspace(35, 65, 1000);
Pfa = 1 - normcdf((beta1 - r1)/sqrt(r1*(4-pi)/pi));

% Pfa = linspace(10e-1, 10e-10, 1000);
% beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;

semilogy(beta1, Pfa, 'color', 'b', 'linewidth', 1.3);

% legend('����ֵ');

xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{fa}$', 'interpreter', 'latex');

grid on;

% �����龯��