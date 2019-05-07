clear, clc;
close all;

fs = 22; % MHz ����Ƶ�ʣ�Ӧ���� 2 * 1090
Tb = 1; % us
t0 = -20 : 1/fs : 140;
b = @(t, d)(d - 0.5)*(rect(t) - rect(t - Tb / 2.0));

scrsz = get(0,'ScreenSize'); % ��ȡ��Ļ�ߴ�

% >>> ������ͷ <<<
h = zeros(1, length(t0));
for i = 0 : 1 : 15
    h = h + (-0.5) * rect(t0 - i * Tb / 2);
end
h = h + rect(t0) + rect(t0 - 1) + rect(t0 - 3.5) + rect(t0 - 4.5);

% >>> �������ݱ��� <<<
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

% >>> �ϳɻ����ź� <<<
a = h + d;
for k = 0 : 1 : 239
    a = a + 0.5 * rect(t0 - k * Tb / 2);
end

% >>> �ı�����źŵ�ƽ <<<
A = 40;
a = A * a;

figure;
plot(t0, a, 'color', 'k', 'linewidth', 1.5);
title('�����ź�a');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -A 2 * A]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 31), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> �����˹������ <<<
% �����źŹ���
sigPower = 29 * A^2 / 60;
SNR = 1; % ������ʽ
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(a));
y = a + noise;

figure;
stem(t0, y, 'color', 'k', 'linewidth', 1);
hold on;
stem(t0, abs(y), 'color', 'r', 'linewidth', 1);
legend('y', '|y|');
title(['��������ź�y��|y|�������SNR=',num2str(SNR),'��']);
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y) max(y)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 31), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> ������ۻ� <<<
% M ��������ۻ�
M = 4;
y_cumu = zeros(1, length(y) - M);
for m = 1 : length(y) - M
    y_cumu(m) = 1 / M * dot(y(m + 1 : m + M), y(m : m + M - 1));
end

figure;
stem(t0(1 : length(y_cumu)), y_cumu, 'color', 'k', 'linewidth', 1);
hold on;
stem(t0(1 : length(y_cumu)), abs(y_cumu), 'color', 'r', 'linewidth', 1);
legend('y_{cumu}', '|y_{cumu}|');
title('y��������ۻ�y_{cumu}��|y_{cumu}|');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) min(y_cumu) max(y_cumu)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', linspace(0, 120, 31), 'ytick', linspace(-A, 2 * A, 4), 'fontsize', 13);
set(gca, 'yticklabel', {'-A', '0', 'A', '2A'});

% >>> ��ͷ������޶�ָ̬�꣨��ƽָ�꣩<<<
% ��׼��ͷ���ģ��
preambleTemp = [ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 44) ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 66)];

adsbStd = a(441 : 3080);
ra1 = dot(preambleTemp, adsbStd(1 : 176)) / mean(adsbStd(1 : 176));
disp(['����ģ�ͱ�ͷ������ֵ֮�ȣ����ۣ��� ', num2str(ra1)]);

ra2 = zeros(2, 2464);
for i = 176 : 2464
    sig = adsbStd(i + 1 : i + 176); 
    ra2(1, i) = dot(preambleTemp, sig) / mean(sig);
end
disp(['����ģ���źŶγ���ͷ�ξ�����ֵ֮�ȣ����ۣ�ͳ��ƽ������ ', num2str(mean(ra2(1, :)))]);

% �����źţ��ı�SNR��
adsbReal = y(441 : 3080);
ra1n = dot(preambleTemp, adsbReal(1 : 176)) / mean(adsbReal(1 : 176));
disp(['����ģ�ͱ�ͷ������ֵ֮�ȣ����룬��������1���� ', num2str(ra1n)]);

for i = 176 : 2464
    sig = adsbReal(i + 1 : i + 176); 
    ra2(2, i) = dot(preambleTemp, sig) / mean(sig);
end
disp(['����ģ���źŶγ���ͷ�ξ�����ֵ֮�ȣ����룬ͳ��ƽ������ ', num2str(mean(ra2(2, :)))]);

figure;
hold on;
plot(1:length(ra2(1,:)) , ra2(1,:), 'color', 'r');
plot([1, length(ra2(1,:))], [mean(ra2(1,:)), mean(ra2(1,:))], 'color', 'g');
plot(1:length(ra2(2,:)) , ra2(2,:), 'color', 'b');
plot([1, length(ra2(2,:))], [mean(ra2(2,:)), mean(ra2(2,:))], 'color', 'm');
legend('�����ź�', '�����ֵ', '�����ź�', '�����ֵ');
title('�ź��ڷǱ�ͷ�α�������������+���룩');
xlabel('����');
ylabel('����');
axis([1 length(ra2(1,:)) 0 100]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 1 : 500 : length(ra2(1,:)), 'ytick', 0 : 20 : 100, 'fontsize', 13);

% ������ͳ������
noiseSeq = abs([y(1 : 440), y(3081 : 3521)]);
ra3 = zeros(1, length(noiseSeq) - 176);
for i = 1 : length(noiseSeq) - 176
    ra3(i) = dot(preambleTemp, noiseSeq(i + 1 : i + 176)) / mean(noiseSeq(i + 1 : i + 176));
end

disp(['����������ͳ��ƽ������ ', num2str(mean(ra3))]);

figure;
plot(1:length(ra3) , ra3);
hold on;
plot([1, length(ra3)], [mean(ra3), mean(ra3)]);
title('��������������');
xlabel('����');
ylabel('����');
axis([1 length(ra3) 20 70]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 1 : 100 : length(ra3), 'ytick', 20 : 5 : 70, 'fontsize', 13);

disp(['�����Լ�����޵�Ӱ�죨���ͱ�������', num2str(ra1 / ra1n)]);

% >>> ��ͷ������޶�ָ̬�꣨����ָ�꣩ <<<

disp(' ');

% preambleTemp = A * preambleTemp;

% �����ź�
preamblePower = sum(adsbStd(1 : 176) .^ 2) / 176;
ra1 = dot(preambleTemp, adsbStd(1 : 176)) / preamblePower;
disp(['����ģ�ͱ�ͷ������ֵ֮�ȣ����ۣ��� ', num2str(ra1)]);

ra2 = zeros(2, 2464);
for i = 176 : 2464
    sig = adsbStd(i + 1 : i + 176); 
    ra2(1, i) = dot(preambleTemp, sig) / (sum(sig .^ 2) / 176);
end
disp(['����ģ���źŶγ���ͷ�ξ�����ֵ֮�ȣ����ۣ�ͳ��ƽ������ ', num2str(mean(ra2(1, :)))]);

% �����źţ��ı�SNR��
preamblePower = sum(adsbReal(1 : 176) .^ 2) / 176;
ra1n = dot(preambleTemp, adsbReal(1 : 176)) / preamblePower;
disp(['����ģ�ͱ�ͷ������ֵ֮�ȣ����룬��������1���� ', num2str(ra1n)]);

for i = 176 : 2464
    sig = adsbReal(i + 1 : i + 176); 
    ra2(2, i) = dot(preambleTemp, sig) / (sum(sig .^ 2) / 176);
end
disp(['����ģ���źŶγ���ͷ�ξ�����ֵ֮�ȣ����룬ͳ��ƽ������ ', num2str(mean(ra2(2, :)))]);

% ������
noiseSeq = abs([y(1 : 440), y(3081 : 3521)]);
ra3 = zeros(1, length(noiseSeq) - 176);
for i = 1 : length(noiseSeq) - 176
    noisePower = sum(noiseSeq(i + 1 : i + 176) .^ 2) / 176;
    ra3(i) = dot(preambleTemp, noiseSeq(i + 1 : i + 176)) / noisePower;
end
disp(['����������ͳ��ƽ������ ', num2str(mean(ra3))]);

disp(['�����Լ�����޵�Ӱ�죨���ͱ�������', num2str(ra1 / ra1n)]);

disp(' ');
disp(['����ƽ�����ʣ�', num2str(sum(noiseSeq .^ 2) / length(noiseSeq)), 'W']);
disp(['��ͷƽ�����ʣ�', num2str(preamblePower), 'W']);

power = zeros(1, length(y) - 176);
for i = 1 : length(y) - 175
    power(i) = sum(y(i : i + 176 - 1) .^ 2) / 176;
end
figure;
plot(power);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);





