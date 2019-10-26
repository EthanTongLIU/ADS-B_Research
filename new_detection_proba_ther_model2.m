% �򻯵�ģ�ͣ��ǰ���첨�����µļ�������ģ��

format long;

% 1. �̶� r1��beta1 ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������ѡ��������Ϊ22M

SNR = 10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

grid on;