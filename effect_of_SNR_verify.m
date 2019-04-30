clear, clc;
close all;

fs = 22; % MHz ����Ƶ�ʣ�Ӧ���� 2 * 1090
Tb = 1; % us
t0 = -20 : 1/fs : 140;
b = @(t, d)(d - 0.5)*(rect(t) - rect(t - Tb / 2.0));

scrsz = get(0,'ScreenSize'); % ��ȡ��Ļ�ߴ�

% % >>> PPM ����ʾ��ͼ <<<
% figure;
% ppm1 =   0.5 * (rect(t0 - 7 * Tb) - rect(t0 - 7 * Tb - 0.5));
% ppm0 = - 0.5 * (rect(t0 - 7 * Tb) - rect(t0 - 7 * Tb - 0.5));
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
h = zeros(1, length(t0));
for i = 0 : 1 : 15
    h = h + (-0.5) * rect(t0 - i * Tb / 2);
end
h = h + rect(t0) + rect(t0 - 1) + rect(t0 - 3.5) + rect(t0 - 4.5);

% figure;
% plot(t0, h, 'color', 'b', 'linewidth', 1.5);
% title('��ͷ��');
% xlabel('Time(\mus)');
% ylabel('Amplitude');
% axis([t0(1) t0(end) -2 2]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

% >>> �������ݱ��� <<<
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

% figure;
% plot(t0, d, 'color', 'r', 'linewidth', 1.5);
% title('���ݱ��Ķ�');
% xlabel('Time(\mus)');
% ylabel('Amplitude');
% axis([t0(1) t0(end) -2 2]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

% >>> �ϳɻ����ź� <<<
a = h + d;
for k = 0 : 1 : 239
    a = a + 0.5 * rect(t0 - k * Tb / 2);
end

figure;
plot(t0, a, 'color', 'k', 'linewidth', 1.5);
title('�����ź�');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

% >>> �ı�����źŵ�ƽ <<<
A = 40;
a = A * a;

% % >>> ���������������ú����� <<<
% figure;
% SNR = 0.2; % ����ȣ���λ dB ���Ǳ�ֵ 
% y = abs(awgn(a, SNR, 'measured', 'linear')); % �Ȳ����ź�ǿ�ȣ���λ dBW/W
% plot(t0, y);
% title('�����ź�');
% xlabel('Time(\mus)');
% ylabel('Amplitude');
% axis([t0(1) t0(end) 0 A * 3]);
% set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
% set(gca, 'box', 'off', 'xtick', 0 : 4 : 120, 'ytick', 0 : floor(A / 3) : A * 3, 'fontsize', 13);

% >>> ����խ����˹������ <<<
% �����źŹ���
sigPower = sum(abs(a) .^ 2) / length(a)
SNR = 1; % ������ʽ
noisePower = sigPower / SNR
noisePower = 29 * A^2 / (60 * SNR)
nbNoiseC = sqrt(noisePower) .* randn(1, length(a)); % ͬ�����
% nbNoise = abs(hilbert(nbNoiseC)); % ���� Hilbert �任�õ���������������
y = a + nbNoiseC;

% >>> ������ۻ� <<<
% 5 ��������ۻ�
for i = 1 : length(y) - 5
    y(i) = dot(y(i : i + 4), y(i + 1 : i + 5));
end

y = abs(y);
figure;
stem(t0, y);
title('�����ź�');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) 0 max(y)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0 : 4 : 120, 'ytick', linspace(min(y), max(y), 10), 'fontsize', 13);

% >>> ��ͷ������޶�ָ̬�꣨��ƽָ�꣩<<<
% �����ź�
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





