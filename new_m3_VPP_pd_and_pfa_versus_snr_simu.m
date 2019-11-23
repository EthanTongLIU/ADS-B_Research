% VPP(��Ч����λ��)����㷨ģ��

clear, clc;
close all;

% --- ���ɻ����ź�

fs = 22; % �����ʣ���λ��MHz
Tb = 1; % ��Ԫ��ȣ���λ��us
t0 = -80 : 1/fs : 200; % ʱ�����У���λ��us
b = @(t, d)d * rect(t) + (1-d) * rect(t-Tb/2.0); % ����λ�õ�����Ԫ

% ��ͷ
% p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 2, 1) + b(t0 - 3, 0) + b(t0 - 4, 0) + b(t0 - 5, 1) + b(t0 - 6, 1) + b(t0 - 7, 1);
p = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 3, 0) + b(t0 - 4, 0);

% �����ź�
m = p;

% �����ź�
alpha = 2; % �����źŵ�ƽ

M = 8 * fs; % 8us ����Ӧ�Ĳ�������

SNR = 15; % ����ȣ�dB��ʽ(�ֱ�ȡ10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
sigma = sqrt(alpha^2 / SNR); % ������׼��

% 0.1572 0.1337 0.1109 0.0894 0.0697 0.0522 0.0374 0.0254 0.0162 0.0096
% 0.0053 0.0027 0.0014 7.9617e-4 6.1862e-4 6.0936e-4 6.7405e-4 7.5449e-4
% 8.3718e-4 9.0326e-4 9.5197e-4 9.6724e-4 9.622e-4 9.3810e-4

% ѭ����ʼ��
cycletime = 20000;
passtime = 0; % ͨ���Ĵ���
pd = 0;
pfa = 0; % �龯����
for k = 1 : cycletime
    
    % ��������
    e = wgn(1, length(p), sigma^2, 'linear');
    % e = raylrnd(sigma, 1, length(p));

    % ������Ƶ�ź�
    sd = (alpha * m + e).^2; % ��λ��W

    % ȡ������Ƶ�ź�
    sd_log = 10*log10(abs(sd)*1000); % ��λ��dBm

    % --- ����threshold���Ƿ�Ӧ������ȡ6dB(���ڹ���)��
    thres = 10*log10((alpha)^2*1000) - 6;
    % thres = 10*log10((alpha+sqrt(pi/2)*sigma)^2*1000) - 6; % ��λ��dBm
    
    % --- ��thres���µ��źŶ���
    sd_log(sd_log<thres) = thres;
    
    % --- ��ȡVPP��LE���ж�4����λ�ã�ȷ���Ƿ�Ϊpreamble
    NC = 6; % ������22M��Ӧ��VPP������������
    VPP = zeros(1, length(sd) - NC); % ��¼VPP��λ��
    LE = zeros(1, length(sd) - NC); % ��¼LE��λ��
    for i = 3 : length(sd) - NC % 1761-3 : 1860+3 % Ϊ��ʡ����ʱ�䣬���̼��㷶Χ
        if (sd_log(i)>thres)&&(sd_log(i+1)>thres)&&(sd_log(i+2)>thres)&&...
            (sd_log(i+3)>thres)&&(sd_log(i+4)>thres)&&(sd_log(i+5)>thres)&&(sd_log(i+6)>thres)
            VPP(i) = 1;
            if (sd(i) - sd(i-1)) > 2.18 % �ж���VPP�Ƿ�ΪLE��2.18dB = 48dB/22��
                LE(i) = 2;
            end
        end
    end
    
%     % ׼ȷ��������λ�ã�1761 1783 1838 1860
%     n_LE = 0; % 4��VPP�������ص��������ݴ������λ��Ϊǰ���2
%     if (LE(1761-2)==2) || (LE(1761-1)==2) || (LE(1761)==2) || (LE(1761+1)==2) || (LE(1761+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if (LE(1783-2)==2) || (LE(1783-1)==2) || (LE(1783)==2) || (LE(1783+1)==2) || (LE(1783+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if (LE(1838-2)==2) || (LE(1838-1)==2) || (LE(1838)==2) || (LE(1838+1)==2) || (LE(1838+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if (LE(1860-2)==2) || (LE(1860-1)==2) || (LE(1860)==2) || (LE(1860+1)==2) || (LE(1860+2)==2)
%         n_LE = n_LE + 1;
%     end
%     if n_LE >= 2
%         passtime = passtime + 1;
%     end 
    
    n_LE = 0; % 4��VPP�������ص��������ݴ������λ��Ϊǰ���1
    if (LE(1761-1)==2) || (LE(1761)==2) || (LE(1761+1)==2)
        n_LE = n_LE + 1;
    end
    if (LE(1783-1)==2) || (LE(1783)==2) || (LE(1783+1)==2)
        n_LE = n_LE + 1;
    end
    if (LE(1838-1)==2) || (LE(1838)==2) || (LE(1838+1)==2)
        n_LE = n_LE + 1;
    end
    if (LE(1860-1)==2) || (LE(1860)==2) || (LE(1860+1)==2)
        n_LE = n_LE + 1;
    end
    if n_LE >= 2
        passtime = passtime + 1;
    end 
    
    pfa = pfa + length(LE(LE>0))/length(LE);
    
end

passtime
pd = passtime / cycletime
pfa = pfa / cycletime

figure;
hold;
plot(sd_log);
plot([0 length(sd_log)], [thres thres], '-.');
plot(10*log10(abs(alpha^2 * p)*1000), '.');

figure;
hold on;
stem(VPP);
stem(LE);
axis([0 length(VPP) 0 3]);



