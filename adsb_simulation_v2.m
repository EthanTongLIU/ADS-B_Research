clear, clc;
close all;

fs = 5000; % MHz ����Ƶ�ʣ�Ӧ���� 2 * 2 * 1090
Tb = 1; % us
t0 = -20 : 1/fs : 140;
b = @(t, d)d * rect(t) + (1 - d) * rect(t - Tb / 2.0);

scrsz = get(0,'ScreenSize'); % ��ȡ��Ļ�ߴ�

% % >>> PPM ����ʾ��ͼ <<<
% figure;
% ppm1 = b(t0 - 7 * Tb, 1); 
% ppm0 = b(t0 - 7 * Tb, 0);
% subplot(121);
% plot(t0(length(t0(t0<=5)):length(t0(t0<=10))), ppm1(length(t0(t0<=5)):length(t0(t0<=10))), 'linewidth', 2, 'color', 'r');
% xlabel('Time(\mus)');
% ylabel('Amplitude');
% set(gca, 'box', 'off', 'xtick', 7:0.5:8, 'ytick', -1:0.5:1);
% set(gca, 'xticklabel', {'t_s','t_s+0.5','t_s+1'}, 'fontsize', 15);
% subplot(122);
% plot(t0(length(t0(t0<=5)):length(t0(t0<=10))), ppm0(length(t0(t0<=5)):length(t0(t0<=10))), 'linewidth', 2, 'color', 'r');
% xlabel('Time(\mus)');
% ylabel('Amplitude');
% set(gca, 'box', 'off', 'xtick', 7:0.5:8, 'ytick', -1:0.5:1);
% set(gca, 'xticklabel', {'t_s','t_s+0.5','t_s+1'}, 'fontsize', 15);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);

% >>> ������ͷ <<<
% h = rect(t0) + rect(t0 - 1) + rect(t0 - 3.5) + rect(t0 - 4.5);

h = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 3, 0) + b(t0 - 4, 0);

figure;
plot(t0, h, 'color', 'k', 'linewidth', 1.5);
title('��ͷ��');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', linspace(-1,1,5), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '', '0', '', 'A'});

% >>> �������ݱ��� <<<
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

figure;
plot(t0, d, 'color', 'k', 'linewidth', 1.5);
title('���ݱ��Ķ�');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', linspace(-1,1,5), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '', '0', '', 'A'});

% >>> �ϳɻ����ź� <<<
a = h + d;

figure;
plot(t0, a, 'color', 'k', 'linewidth', 1.5);
title('�����ź�');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', linspace(-1,1,5), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '', '0', '', 'A'});

% % �����ź�Ƶ��
% N = length(a);
% NFFT = 2^nextpow2(N);
% A = fft(a, NFFT) / N;
% f = fs / 2 * linspace(0, 1, NFFT/2 + 1);
% figure;
% plot(f, 2 * abs(A(1 : NFFT / 2 + 1)), 'linewidth', 1.5, 'color', 'k');
% xlabel('Frequency(MHz)');
% ylabel('|A|');
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'fontsize', 13);

% %�����źŹ����ף�ֱ�ӷ���
% window = boxcar(N);
% [Pxx, fa] = periodogram(a, window, NFFT, fs);
% figure;
% plot(fa, 10 * log10(Pxx));
% title('������');
% xlabel('Frequency(MHz)');
% ylabel('Pxx(dB)');
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'fontsize', 13);
% 
% % �����źŹ����ף�Bartlett����
% noverlap = 0; % �������ص�
% p = 0.9; % ���Ÿ���
% [Pxx, Pxxc] = psd(a, NFFT, fs, window, noverlap, p);
% index = 0 : round(NFFT / 2 - 1);
% k = index * fs / NFFT;
% plot_Pxx = 10 * log10(Pxx(index + 1));
% plot_Pxxc = 10 * log10(Pxxc(index + 1));
% figure;
% plot(k, plot_Pxx);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% figure;
% plot(k, [plot_Pxx plot_Pxx - plot_Pxxc plot_Pxx + plot_Pxxc]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);

% % >>> ��ѧ���� <<<
% E = h;
% for k = 1 : 112
%     E = E + 0.5 * rect(t0 - (k + 7) * Tb) + 0.5 * rect(t0 - (k + 7.5) * Tb);
% end
% figure;
% plot(t0, E, 'color', 'k', 'linewidth', 1.5);
% title('��ѧ����');
% xlabel('Time(\mus)');
% ylabel('Amplitude');
% axis([t0(1) t0(end) -2 2]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', 0:120:120, 'ytick', -1:0.5:1, 'fontsize', 13);
% set(gca, 'xticklabel', {'t_0','t_0+120'}, 'fontsize', 15);

% >>> ��Ƶ�ź� <<<
f0 = 1090; % MHz
s = a .* cos(2 * pi * f0 * t0);

figure;
plot(t0, s, 'color', 'k', 'linewidth', 1.2);
title('��Ƶ�ź�');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);
set(gca, 'box', 'off', 'fontsize', 13);

N = length(s);
% NFFT = 2^nextpow2(N);
% S = fft(s, NFFT) / N;
% f = fs / 2 * linspace(0, 1, NFFT/2 + 1);
% figure;
% plot(f, 2 * abs(S(1 : NFFT / 2 + 1)), 'color', 'k', 'linewidth', 1.5);
% xlabel('Frequency(MHz)');
% ylabel('|S|');
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'fontsize', 13);

% >>> ��Ƶ�źżӸ�˹������ <<<

% 1. ȷ����Ƶ�źŹ���
% 2. ȷ�������
% 3. ȷ��խ����˹������ ni ���ʣ�խ����˹��������
% 4. ��������

rfSigPower = sum(abs(s) .^ 2) / N;
SNR = 3; % ����
noisePower = rfSigPower / SNR;
noise = sqrt(noisePower) * randn(1, N);

s = s + noise;

% % >>> ��Ƶ�źų˱����ز� <<<
s = s .* cos(2 * pi * f0 * t0);
figure;
plot(t0, s, 'color', 'k', 'linewidth', 1.2);
title('��Ƶ�źų�����ز�');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

% >>> ����ź�ͨ����ͨ�˲��� <<<
N = length(s);
NFFT = 2^nextpow2(N);
S = fft(s, NFFT) / N;
f = fs / 2 * linspace(0, 1, NFFT/2 + 1);
figure;
plot(f, 2 * abs(S(1 : NFFT / 2 + 1)));
xlabel('Frequency(MHz)');
ylabel('|S|');
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);

% ������ͨ�˲���
fp = 500; % ��ֹƵ�� MHz
LPF = [ones(1, floor(NFFT / (fs / fp))) zeros(1, 2 * (NFFT / 2 - floor(NFFT / (fs / fp)))) ones(1, floor(NFFT / (fs / fp)))];

% ����ź�ͨ�� LPF
S = S .* LPF;
figure;
plot(f, 2 * abs(S(1 : NFFT / 2 + 1)));
xlabel('Frequency(MHz)');
ylabel('|S|');
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);

%%
figure;
s = ifft(S, NFFT) * N;
s = s(1 : N);
plot(t0, s, 'color', 'k');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

%%
figure;
s0 = s(1 : 180 : end);
plot(t0(1 : 180 : end), abs(s0), 'color', 'k');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);