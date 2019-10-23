clear, clc;
close all;

%% ��� FIR ��ͨ�˲���
% �˲�������
N = 161;
% ����Ƶ�ʣ���λ��Hz
fs = 2000;
% ��ͨ�˲�����ֹƵ�ʣ���λ��Hz
fc_lpf = 200;
% �Բ���Ƶ��Ϊ��׼����Ƶ�ʹ�һ��
wn_lpf = fc_lpf*2/fs;
% ����fir1�������FIR�˲���
b_lpf = fir1(N-1, wn_lpf);
% ���Ƶ��Ӧ
m_lpf = 20*log10(abs(fft(b_lpf)));
% ����Ƶ����Ӧ�ĺ����굥λΪHz
x_f = 0:(fs/length(m_lpf)):fs/2;

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

%% ���ԭʼ�����ź�xx
L = 1500; % �źų���
t = (0:L-1)*1/fs; % ʱ��
xx = 0.7*sin(2*pi*60*t) + sin(2*pi*140*t) + randn(size(t)); % �ź�

figure;
subplot(121);
plot(1000*t, xx);
xlabel('t/ms');
ylabel('xx(t)');
title('xx');

XX = fft(xx);     % ��⸵��Ҷ�任
P2 = abs(XX/L);   % ˫��Ƶ��
% P1 = P2(1:L/2+1); % ���㵥���ź�Ƶ��
% P1(2:end-1) = 2*P1(2:end-1);

f = fs/L*(0:L-1); % ����

% f = fs * (0:(L/2))/L;
subplot(122);
plot(f(1:L/2), P2(1:L/2));
xlabel('f(Hz)');
ylabel('����');
title('xx��Ƶ��XX');

%% ��xx�����˲����õ�yy
yy = filter(b_lpf, 1, xx);

figure;
subplot(121);
plot(1000*t, yy);
xlabel('t/ms');
ylabel('yy(t)');

YY = fft(yy);
P2 = abs(YY/L);
% P1 = P2(1:L/2+1);
% P1(2:end-1) = 2*P1(2:end-1);

subplot(122);
plot(f(1:L/2), P2(1:L/2));
xlabel('f(Hz)');
ylabel('����');
title('yy��Ƶ��YY');