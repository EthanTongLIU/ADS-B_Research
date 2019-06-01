clear, clc;
close all;

fs = 22; % MHz ����Ƶ�ʣ�Ӧ���� 2 * 1090
Tb = 1; % us
t0 = -80 : 1/fs : 200; % ʱ�����У����� 0-120 Ϊ ADS-B ����
b = @(t, d)d * rect(t) + (1 - d) * rect(t - Tb / 2.0);

% ��ͷ
h = b(t0, 1) + b(t0 - 1, 1) + b(t0 - 3, 0) + b(t0 - 4, 0);

% ���ݿ�
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

% �����ź�
a = h + d; A = 40; a = A * a;

% ��������
sigPower = 29 * A^2 / 60;
SNR = 1; % ������ʽ

% ��׼��ͷ���ģ��
n_half_us = fs / 2;
preambleTemp = [ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) zeros(1, 4 * n_half_us) ones(1, n_half_us) zeros(1, n_half_us) ones(1, n_half_us) zeros(1, 6 * n_half_us)];

% ��ѭ��
thr_num = 1;
threshold = linspace(0.4, thr_num);

% Сѭ��
snr_num = 11; 
SNRdB = linspace(-5, 5, snr_num); % dB ��ʽ������ 1 dB 
SNR = power(10, SNRdB / 10.0); % ������ʽ

pass = zeros(thr_num, snr_num);

for thr_i = 1 : thr_num
    for snr_i = 1 : snr_num
        for id = 1 : 200
            noisePower = sigPower / SNR(snr_i);
            noise = raylrnd(sqrt(noisePower), 1, length(a));
            y = a + noise;

            K = 8 * fs;
            R = zeros(1, length(y) - K + 1);
            mu = zeros(1, length(y) - K + 1);
            for m = 1 : length(y) - K + 1
                mu(m) = mean(y(m : m + K - 1));
                R(m) = 1 / K * preambleTemp * y(m : m + K - 1)';
            end
            lambda = R ./ mu;

            tags = find(lambda > threshold(thr_i));

            % ͳ�Ƽ����
            if find(tags == 1761)
                pass(thr_i, snr_i) = pass(thr_i, snr_i) + 1;
            end

        end
        disp(['    �ֲ�����', num2str(snr_i), '/', num2str(snr_num), ', ', num2str(SNRdB(snr_i)),'dB']);
    end
    disp(['�ܽ���', num2str(thr_i), '/', num2str(4)]);
end

%%
figure;
hold on;
for thr_i = 1 : thr_num
    plot(SNRdB, pass(thr_i, :) / 200 * 100, '-o', 'color', 'k', 'linewidth', 3);
end
grid on;
set(gca, 'gridlinestyle', '--', 'gridalpha', 0.8);

axis([-5 5 0 100]);
set(gca, 'box', 'on', 'xtick', -5 : 1 : 5, 'ytick', linspace(0, 100, 11), 'fontsize', 22);

xlabel('����ȣ�dB��', 'fontsize', 30, 'fontweight', 'bold');
ylabel('����ʣ�%��', 'fontsize', 30, 'fontweight', 'bold');
lambda = R ./ mu;
