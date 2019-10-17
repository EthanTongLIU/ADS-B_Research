% ����ٱ�ͷ���Ϊ��ͷ�ĸ��� Pe

clear, clc;
close all;
format long;

% ����ֵ

% ������ 22M���� 8us ������Ϊ 176��r1 = 44��r0 = 132
r1 = 44;
r0 = 132;
r2 = r0 - r1;

%% beta1 ��Ϊ����

figure;
hold on;
xlabel('\beta_{1}');
ylabel('P_{e}');

beta1 = linspace(0.1, 100, 100);

for SNR = pi / 4 : pi / 4 : pi
    beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
    Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
    plot(beta1, Pe, 'color', 'b');
end

%% SNR ��Ϊ����

figure;
hold on;
xlabel('SNR');
ylabel('P_{e}');

SNR = linspace(0.5, 5, 100);

for beta1 = 0.1 : 10 : 100
    beta2 = sqrt(2/pi) * r1 / r0 * sqrt(SNR) + r2 / r0;
    Pe = 1 - normcdf(beta1 * beta2 * sqrt(pi/(2*r1)) - sqrt(r1) * sqrt(SNR));
    plot(SNR, Pe, 'color', 'b');
end

plot([pi/2, pi/2], [0, 1], '-.', 'color', 'r');



