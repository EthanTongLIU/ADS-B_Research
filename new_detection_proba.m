% ����ʦ�޸ĺ�İ汾�ļ�����

format long;

% ���ۼ�����

%% 1. �̶� r1��beta1 ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������ѡ��������Ϊ 22M

SNR = -10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

SNR = -3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 0; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 3; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = linspace(0, 170, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('-10 (����ֵ)', '  -3 (����ֵ)', '   0 (����ֵ)', '   3 (����ֵ)', ' 10 (����ֵ)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');
xlabel('$\beta_{1}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;

%% 2. �̶�r1��SNR ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������������Ϊ 22M

SNR = linspace(0.1, 20, 1000); % ����ȣ�ԭʼ������ʽ

beta1 = 20; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

beta1 = 30; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = linspace(0.1, 20, 200); % ����ȣ�ԭʼ������ʽ

beta1 = 40; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

beta1 = 50; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

beta1 = 60; % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('20 (����ֵ)', '30 (����ֵ)', '40 (����ֵ)', '50 (����ֵ)', '60 (����ֵ)');
title(leg, '\beta_{1}');
xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
grid on;

%% 3. �̶�r1��Pfa ��Ϊ����

clear, clc;
close all;

figure;
hold on;

r1 = 44; % ��������������Ϊ 22M

Pfa = linspace(1e-9, 1e-3, 100000);

SNR = 5; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '-', 'color', [0 0 1], 'linewidth', 1.3);

Pfa = linspace(1e-9, 1e-3, 50000);

SNR = 5.5; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '-.', 'color', [1 0 0], 'linewidth', 1.3);

SNR = 6; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, ':', 'color', [1 0.65 0], 'linewidth', 1.3);

SNR = 6.5; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, ':.', 'color', [1 0 1], 'linewidth', 1.3);

SNR = 10; % ����ȣ�dB��ʽ
SNR = power(10, SNR / 10); % ����ȣ�ԭʼ������ʽ
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(log10(Pfa), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.3);

leg = legend('    5 (����ֵ)', ' 5.5 (����ֵ)', '    6 (����ֵ)', ' 6.5 (����ֵ)', '  10 (����ֵ)');
title(leg, '$SNR/dB$', 'interpreter', 'latex', 'fontname', 'fixedwidth');
xlabel('$P_{fa}$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');

set(gca, 'xtick', [-9 -8 -7 -6 -5 -4 -3], 'xticklabel', {'1e-9', '1e-8', '1e-7', '1e-6', '1e-5', '1e-4', '1e-3'});

grid on;


% ���������

%% 1. pd versus beta1 at different SNR

format long;

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

% ���ݴ洢����
sc = zeros(1, length(sd) - M + 1);
me = zeros(1, length(sd) - M + 1);
cfardata = zeros(1, length(sd) - M + 1);

%% 1. SNR = 10
SNR = 10; % ����ȣ�ԭʼ������ʽ
sigma = sqrt(alpha^2 / SNR); % ������׼��
e = normrnd(0, sigma, 1, length(p));
sd = alpha * m + e;

Pfa = 1e-6; % �龯����
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa) + r1; % �������

fndnum = 0;
for m = 1 : length(sd) - M + 1
    me(m) = mean(abs([sd(m+11:m+11+11-1), sd(m+33:m+33+11-1), sd(m+77:m+77+11-1), sd(m+99:m+99+11-1)])); % ���������ֵ
    sc(m) = abs(pd * sd(m : m+M-1)');
    if (sc(m) / me(m) > beta1)
        cfardata(m) = sc(m) / me(m);
        fndnum = fndnum + 1;
        if m == 1761
            break;
        end
    end
end

plot(cfardata);
title(num2str(fndnum));


















