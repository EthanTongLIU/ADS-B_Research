%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������

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
SNR = 5; % ����ȣ�ԭʼ������ʽ(�ֱ�ȡ10, 6.5, 6, 5.5, 5)
sigma = sqrt(alpha^2 / SNR); % ������׼��

% -----> �ڲ�ѭ��(�龯����)
Pfa = 1e-9; % �龯����(�ֱ�ȡ�龯����1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9)
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa) + r1; % �������

passtime = 0; % ��⵽��ͷ�Ĵ�����¼
for cycletime = 1 : 10000 % �ظ��������ؿ������ʵ��

    e = normrnd(0, sigma, 1, length(p)); % ���¹�������
    sd = alpha * m + e; 

    % ���ݴ洢����
    sc = zeros(1, length(p) - M + 1);
    me = zeros(1, length(p) - M + 1);
    cfardata = zeros(1, length(p) - M + 1);

    % fndnum = 0; % ÿ���ҵ��ı�ͷ��Ŀ
  % for i = 1 : length(sd) - M + 1
    for i = 1760 : 1761
        me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+11-1), sd(i+77:i+77+11-1), sd(i+99:i+99+11-1)])); % ���������ֵ
        sc(i) = abs(pd * sd(i : i+M-1)'); % ������ͽ��
        if (sc(i) / me(i) > beta1)
            % cfardata(i) = sc(i) / me(i);
            % fndnum = fndnum + 1;
            if i == 1761
                passtime = passtime + 1;
                break;
            end
        end
    end
    
end

passtime

% plot(cfardata);
% title(num2str(fndnum));