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

SNR = 10; % ����ȣ�dB��ʽ(�ֱ�ȡ10, 3, 0, -3, -10)
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
sigma = sqrt(alpha^2 / SNR); % ������׼��

e = wgn(1, length(p), sigma^2, 'linear');
% e = raylrnd(sigma, 1, length(p));

% ��Ƶ�ź�
sd = alpha * m + e;

% --- ȡ������Ƶ�ź�
sd = 10*log10(abs(sd)*1000);
figure;
hold;
plot(sd); % ��λ��dBm

% --- ����threshold (û����)
thres = 31; % ��λ��dBm
plot([0 length(sd)], [thres thres], '-.');
% mrl = -88 + 4; % ��λ��dBm

plot(10*log10(abs(alpha * p)*1000), '.');

% --- ��ȡVPP��LE���ж�4����λ�ã�ȷ���Ƿ�Ϊpreamble
NC = 6;
VPP = zeros(1, length(sd) - NC);
LE = zeros(1, length(sd) - NC);
for i = 1 : length(sd) - NC
    if (sd(i)>thres)&&(sd(i+1)>thres)&&(sd(i+2)>thres)&&(sd(i+3)>thres)&&(sd(i+4)>thres)&&(sd(i+5)>thres)&&(sd(i+6)>thres)
        VPP(i) = 1;
        if (sd(i) - sd(i-1)) > 2.18 % �������ж���2.18dB = 48dB/22��
            LE(i) = 2;
        end
    end
end
figure;
hold on;
stem(VPP);
stem(LE);
axis([0 length(VPP) 0 3]);
% 1761 1783 1838 1860
if (LE(1761-2)==2) || (LE(1761-1)==2) || (LE(1761)==2) || (LE(1761+1)==2) || (LE(1761+2)==2)
    if (LE(1783-2)==2) || (LE(1783-1)==2) || (LE(1783)==2) || (LE(1783+1)==2) || (LE(1783+2)==2)
        if (LE(1838-2)==2) || (LE(1838-1)==2) || (LE(1838)==2) || (LE(1838+1)==2) || (LE(1838+2)==2)
            if (LE(1860-2)==2) || (LE(1860-1)==2) || (LE(1860)==2) || (LE(1860+1)==2) || (LE(1860+2)==2)
                disp('yes');
            end
        end
    end
end

% if (LE(1761)==2) && (LE(1783)==2) && (LE(1838)==2) && (LE(1860)==2)
%     disp('pass');
% else
%     disp('no');
% end




