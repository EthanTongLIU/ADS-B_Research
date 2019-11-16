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

% �����ͨ�˲��������ڶԸ�˹����������խ���˲�
N_lpf = 161; % �˲�������
fc_lpf = 100; % ��ͨ�˲�����ֹƵ�ʣ���λ��Hz
wn_lpf = fc_lpf*2/(fs*1e6); % �Բ���Ƶ��Ϊ��׼����Ƶ�ʹ�һ��
b_lpf = fir1(N_lpf-1, wn_lpf); % ����fir1�������FIR�˲���
m_lpf = 20*log10(abs(fft(b_lpf))); % ���Ƶ��Ӧ
x_f = 0:(fs/length(m_lpf)):fs/2; % ���ú����꣬��λ��MHz
% �˲�����λ������Ӧ
figure;
subplot(121);
stem(b_lpf);
xlabel('n');
ylabel('h(n)');
title('��ͨ�˲�����λ�弤��Ӧ');
% �˲�����Ƶ��Ӧ
subplot(122);
plot(x_f, m_lpf(1:length(x_f)));
xlabel('Ƶ��(Hz)');
ylabel('����(dB)');
title('��ͨ�˲�����Ƶ��Ӧ');


% -----> ���ѭ��(�����)
SNR = 5; % ����ȣ�ԭʼ������ʽ(�ֱ�ȡ10, 6.5, 6, 5.5, 5)
sigma = sqrt(alpha^2 / SNR); % ������׼��

% -----> �ڲ�ѭ��(�龯����)
Pfa = 1e-9; % �龯����(�ֱ�ȡ�龯����1e-3, 1e-4, 1e-5, 1e-6, 1e-7, 1e-8, 1e-9)
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa) + r1; % �������

passtime = 0; % ��⵽��ͷ�Ĵ�����¼
for cycletime = 1 : 1 % �ظ��������ؿ������ʵ��
    
    e = normrnd(0, sigma, 1, length(p)); % ÿ�����¹�������
    % sd = alpha * m + e; 
    
    en = filter(b_lpf, 1, e);
    
%     %==============����խ������enƵ��=========================
%     figure;
%     subplot(121);
%     plot(t0, en);
%     xlabel('t/us');
%     ylabel('en(t)');
%     
%     EN = fft(en);
%     P2 = EN/length(EN);
%     f = fs/length(EN)*(0:length(EN)-1);
%     subplot(122);
%     plot(f(1:(length(f)+1)/2), P2(1:(length(f)+1)/2));
%     xlabel('f(MHz)');
%     ylabel('����');
%     %========================================================
    
    sd = alpha * m + en; 
    
%     %=================�����ź�sdƵ��==========================
%     figure;
%     subplot(121);
%     plot(t0, sd);
%     xlabel('t/us');
%     ylabel('sd(t)');
%     
%     SD = fft(sd);
%     P2 = SD/length(SD);
%     f = fs/length(SD)*(0:length(SD)-1);
%     subplot(122);
%     plot(f(1:(length(f)+1)/2), P2(1:(length(f)+1)/2));
%     xlabel('f(MHz)');
%     ylabel('����');
%     %=========================================================
    
%     %===================������e����խ���˲�====================
%     % ��e������ʱ����
%     figure;
%     subplot(121);
%     plot(t0, e);
%     xlabel('t/us');
%     ylabel('e(t)');
%     
%     E = fft(e);
%     P2 = E/length(E);
%     f = fs/length(E)*(0:length(E)-1);
%     subplot(122);
%     plot(f(1:(length(f)+1)/2), P2(1:(length(f)+1)/2));
%     xlabel('f(MHz)');
%     ylabel('����');
%     
%     %�����ͨ�˲���
%     N_lpf = 41; % �˲�������
%     fc_lpf = 2000; % ��ͨ�˲�����ֹƵ�ʣ���λ��Hz
%     wn_lpf = fc_lpf*2/(fs*1e6); % �Բ���Ƶ��Ϊ��׼����Ƶ�ʹ�һ��
%     b_lpf = fir1(N_lpf-1, wn_lpf); % ����fir1�������FIR�˲���
%     m_lpf = 20*log10(abs(fft(b_lpf))); % ���Ƶ��Ӧ
%     x_f = 0:(fs/length(m_lpf)):fs/2; % ���ú����꣬��λ��MHz
%     
%     % �˲�����λ������Ӧ
%     figure;
%     subplot(121);
%     stem(b_lpf);
%     xlabel('n');
%     ylabel('h(n)');
%     title('��ͨ�˲�����λ�弤��Ӧ');
% 
%     % �˲�����Ƶ��Ӧ
%     subplot(122);
%     plot(x_f, m_lpf(1:length(x_f)));
%     xlabel('Ƶ��(Hz)');
%     ylabel('����(dB)');
%     title('��ͨ�˲�����Ƶ��Ӧ');
%     
%     en = filter(b_lpf, 1, e);
%     
%     figure;
%     subplot(121);
%     plot(t0, en);
%     xlabel('t/us');
%     ylabel('en(t)');
%     
%     EN = fft(en);
%     P2 = EN/length(EN);
%     f = fs/length(EN)*(0:length(EN)-1);
%     subplot(122);
%     plot(f(1:(length(f)+1)/2), P2(1:(length(f)+1)/2));
%     xlabel('f(MHz)');
%     ylabel('����');
%     %=========================================================
    
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