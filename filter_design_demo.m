clear, clc;
close all;

% �˲�������
N = 41;
% ����Ƶ�ʣ���λ��Hz
fs = 2000;

% ��ͨ�˲�����ֹƵ�ʣ���λ��Hz
fc_lpf = 200;

% �Բ���Ƶ��Ϊ��׼����Ƶ�ʹ�һ��
wn_lpf = fc_lpf*2/fs;

% ����fir1�������FIR�˲���
b_lpf = fir1(N-1, wn_lpf);

% ���Ƶ��Ӧ
m_lpf = 20*log(abs(fft(b_lpf)))/log(10);

% ����Ƶ����Ӧ�ĺ����굥λΪHz
x_f = 0:(fs/length(m_lpf)):fs/2;

% ��λ������Ӧ
figure;
stem(b_lpf);
xlabel('n');
ylabel('h(n)');

% ��Ƶ��Ӧ
figure;
plot(x_f, m_lpf(1:length(x_f)));
xlabel('Ƶ��(Hz)');
ylabel('����(dB)');

% ��ĳһԭʼ����xx�����˲����õ�����yy
L = 1500;
t = (0:L-1)*1/fs;
xx = 0.7*sin(2*pi*60*t) + sin(2*pi*140*t) + randn(size(t));

figure;
plot(1000*t, xx);
xlabel('t/ms');
ylabel('magnitude');

yy = fft(xx);     % ��⸵��Ҷ�任
P2 = abs(yy/L);   % ˫��Ƶ��
% P1 = P2(1:L/2+1); % ���㵥���ź�Ƶ��
% P1(2:end-1) = 2*P1(2:end-1);

f = fs/L*(0:L-1);

% f = fs * (0:(L/2))/L;
figure;
plot(f, P2);
xlabel('f(Hz)');
ylabel('|P1(f)|');

%%
zz = filter(b_lpf, 1, xx);

figure;
plot(1000*t, zz);
xlabel('t/ms');
ylabel('magnitude');

uu = fft(zz);
P2 = abs(uu/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure;
plot(f, P1);
xlabel('f(Hz)');
ylabel('|P1(f)|');