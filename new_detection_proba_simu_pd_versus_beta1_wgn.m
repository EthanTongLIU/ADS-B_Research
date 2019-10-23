%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������
% ����ģ��ֱ�Ӳ��������ֲ�

% 1. pd versus beta1 at different SNR

format long;
clear, clc;
close all;

fs = 22; % �����ʣ���λ��MHz
r1 = 44;
Tb = 1; % ��Ԫ��ȣ���λ��us
t0 = -80 : 1/fs : 200; % ʱ�����У���λ��us
b = @(t, d)d * rect(t) + (1-d) * rect(t-Tb/2.0); % ����λ�õ�����Ԫ

% ��ͷ
p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 3, 0) + b(t0 - 4, 0);

% �����ź�
m = p;

% ���ر�ͷ
n_half_us = fs / 2;
pd = [ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) ...
    zeros(1, 4 * n_half_us) ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) zeros(1, 6 * n_half_us)];

% �����ź�
alpha = 2; % �����źŵ�ƽ

M = 8 * fs; % 8us ����Ӧ�Ĳ�������

% -----> ���ѭ��(�����)
SNR = 10; % ����ȣ�dB��ʽ(�ֱ�ȡ10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
sigma = sqrt(alpha^2 / SNR); % ������׼��

% -----> �ڲ�ѭ��(beta1)
beta1 = 69; % beta1(�ֱ�ȡ20 40 60 80 100 120 140 160)

passtime = 0; % ��⵽��ͷ�Ĵ�����¼
for cycletime = 1 : 20000 % �ظ��������ؿ������ʵ��
    
    e = normrnd(0, sigma, 1, length(p)); 
    sd = alpha * m + e;
    
    % ���ݴ洢����
    sc = zeros(1, length(p) - M + 1);
    me = zeros(1, length(p) - M + 1);
    
    for i = 1760:1761
        me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+11-1), sd(i+77:i+77+11-1), sd(i+99:i+99+11-1)])); % ���������ֵ
        sc(i) = pd * sd(i : i+M-1)'; % ������ͽ��
        if (sc(i) / me(i) > beta1)
            if i == 1761
                passtime = passtime + 1;
                break;
            end
        end
    end
    
end

passtime








