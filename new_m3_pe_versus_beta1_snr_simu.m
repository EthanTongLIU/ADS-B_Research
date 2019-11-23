%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ���������
% pd versus beta1 at different SNR

format long;
clear, clc;
close all;

fs = 22; % �����ʣ���λ��MHz
r1 = 44;
Tb = 1; % ��Ԫ��ȣ���λ��us
t0 = -80 : 1/fs : 200; % ʱ�����У���λ��us
b = @(t, d)d * rect(t) + (1-d) * rect(t-Tb/2.0); % ����λ�õ�����Ԫ

% ��ͷ
p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 2, 1) + b(t0 - 3, 0) + b(t0 - 4, 0) + b(t0 - 5, 1) + b(t0 - 6, 1) + b(t0 - 7, 1);

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
SNR = -5; % ����ȣ�dB��ʽ(�ֱ�ȡ10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
sigma = sqrt(alpha^2 / SNR); % ������׼��

% -----> �ڲ�ѭ��(beta1)
beta1 = 60; % beta1(�ֱ�ȡ20 40 60 80 100 120 140 160

passtime = 0; % ��⵽��ͷ�Ĵ�����¼
for cycletime = 1 : 20000 % �ظ��������ؿ������ʵ��
    
    % ������������������ʽ��ͬ�������ô���˹������
    % e = normrnd(0, sigma, 1, length(p));
    % e = wgn(1, length(p), sigma^2, 'linear');
    
    % ������������һ�������ֲ��İ���
    e = raylrnd(sigma, 1, length(p));
    
    % ������������һ�������ֲ��İ��磬����ȡ����Υ����ʱ�̲�����Ե�ԭ��
    % e = raylrnd(sigma, 1, length(p));
    % e(2:2:end) = -e(2:2:end);
    
    % ���������������ֲ��İ��簴ʱ�̵Ĳ������ȡ��������������ֵ������
    % e = raylrnd(sigma, 1, length(p));
    % coef = (fix(rand(1,length(e))*2)-0.5)*2;
    % e = coef.*e;
   
    % �ź�����
    sd = alpha * m + e;
    
    % ���ݴ洢����
    sc = zeros(1, length(p) - M + 1);
    me = zeros(1, length(p) - M + 1);
    cfardata = zeros(1, length(p) - M + 1);
    
%     % ���μ�������
%     for i = 1 : length(sd) - M + 1
%         me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+44-1), sd(i+88:i+88+11-1), sd(i+110:i+110+66-1)])); % ���������ֵ
%         sc(i) = pd * sd(i:i+M-1)'; % ������ͽ��
%         if (sc(i) / me(i) > beta1)
%             cfardata(i) = sc(i) / me(i);
%         end
%     end
    
    % ���ͳ�Ƽ����
    for i = 1761
        me(i) = mean(abs([sd(i+11:i+11+11-1), sd(i+33:i+33+44-1), sd(i+88:i+88+11-1), sd(i+110:i+110+66-1)])); % ���������ֵ
        sc(i) = pd * sd(i:i+M-1)'; % ������ͽ��
        if (sc(i) / me(i) > beta1)
            if (i == 1761)
                passtime = passtime + 1;
                break;
            end
        end
    end
    
end

% % ���μ�������
% figure;
% subplot(411);
% plot(e);title('e');
% subplot(412);
% plot(sc);title('sc');
% subplot(413);
% plot(me);title('me');
% subplot(414);
% plot(cfardata);title('cfardata');
% [maxcfardata, tag] = max(cfardata)

% ���ͳ�Ƽ����
passtime
pd = passtime/20000








