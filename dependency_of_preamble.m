clear, clc;
close all;

% ��֤����ԣ�������ۻ���

fs = 22; % MHz ����Ƶ�ʣ�Ӧ���� 2 * 2 * 1090
Tb = 1; % us
t0 = -20 : 1/fs : 140;
b = @(t, d)d * rect(t) + (1 - d) * rect(t - Tb / 2.0);

scrsz = get(0,'ScreenSize'); % ��ȡ��Ļ�ߴ�

% >>> ������ͷ <<<
h = rect(t0) + rect(t0 - 1) + rect(t0 - 3.5) + rect(t0 - 4.5);

figure;
plot(t0, h, 'color', 'k', 'linewidth', 1.5);
title('��ͷ��');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(end) -2 2]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0:4:120, 'ytick', -1:0.5:1, 'fontsize', 13);

% >>> �������ݱ��� <<<
K = 112;
d0 = randi(2, 1, K) - 1;
d = zeros(1, length(t0));
for k = 1 : 112
    d = d + b(t0 - (k + 7) * Tb, d0(k));
end

% >>> �ϳɻ����ź� <<<
a = h + d;

% >>> ��ͷ����������� <<<
p = h(441 : 441 + 175);
r = xcorr(p, p) / length(p);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
title('��ͷ�����������');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(0, max(r), 6), 'fontsize', 13);
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);
set(gca, 'yticklabel', {'0', '', '', '', '', [num2str(max(r) / 1.0), 'A'] });

% >>> ��ͷ���������������������� <<<
sigPower = sum(abs(p) .^ 2) / length(p);
SNR = 0.1; % ������ʽ
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(p));

p = p + noise;
r = xcorr(p, p) / length(p);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
title('��ͷ����������������������');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(0, max(r), 6), 'fontsize', 13);
set(gca, 'yticklabel', {'0', '', '', '', '', [num2str(max(r) / 1.0), 'A'] });
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> ��ͷ�������������������� + ������ۻ��� <<<
p_cumu = zeros(1, length(p) - 3);
for i = 2 : length(p) - 3
    p_cumu(i) = 1 / 4 * p(i : i + 3) * p(i - 1 : i + 2)';
end

r = xcorr(p_cumu, p_cumu) / length(p_cumu);

figure;
plot(1 : length(r), r, 'color', 'k', 'linewidth', 1.5);
title('��ͷ�������������������� + ������ۻ���');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(r) min(r) max(r)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(0, max(r), 6), 'fontsize', 13);
set(gca, 'yticklabel', {'0', '', '', '', '', [num2str(max(r) / 1.0), 'A'] });
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> ����ؼ�� <<<
preamble_temp = [ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 44) ones(1, 11) zeros(1, 11) ones(1, 11) zeros(1, 66)];

s = length(a);
m = length(preamble_temp);
R = zeros(1, s - m + 1);

for i = 1 : s - m + 1
    R(i) = preamble_temp * a(i : i + m - 1)';
end

figure;
plot(t0(1 : length(R)), R, 'color', 'k', 'linewidth', 1.5);
title('����ؼ��');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(length(R)) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0 : 8 : 120, 'ytick', linspace(0, max(R), 6), 'fontsize', 13);
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);
set(gca, 'yticklabel', {'0', '', '', '', '', [num2str(max(R) / 1.0), 'A'] });

% >>> ������� <<<
for i = 1 : s - m + 1
    mean_current = mean(a(i : i + m - 1));
    R(i) = preamble_temp * a(i : i + m - 1)' / mean_current;
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('�������');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> ����ؼ�⣨��������� <<<
sigPower = sum(abs(a) .^ 2) / length(a);
SNR = 0.1; % ������ʽ
noisePower = sigPower / SNR;
noise = sqrt(noisePower) .* randn(1, length(a));

a = abs(a + noise);

for i = 1 : s - m + 1
    R(i) = preamble_temp * a(i : i + m - 1)';
end

figure;
plot(t0(1 : length(R)), R, 'color', 'k', 'linewidth', 1.5);
title('����ؼ�⣨���������');
xlabel('Time(\mus)');
ylabel('Amplitude');
axis([t0(1) t0(length(R)) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', 0 : 8 : 120, 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid on;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);
set(gca, 'yticklabel', {[num2str(min(R) / 1.0), 'A'], '', '', '', '', [num2str(max(R) / 1.0), 'A'] });

% >>> ������⣨��������� <<<

for i = 1 : s - m + 1
    mean_current = mean(a(i : i + m - 1));
    R(i) = preamble_temp * a(i : i + m - 1)' / mean_current;
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('������⣨���������');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);

% >>> ������⣨������� + ������ۻ��� <<<
a_cumu = zeros(1, length(a) - 3);
for i = 2 : length(a_cumu) - 3
    a_cumu(i) = 1 / 4 * a(i : i + 3) * a(i - 1 : i + 2)';
end

a_cumu = abs(a_cumu);

for i = 1 : length(a_cumu) - m + 1
    mean_current = mean(a_cumu(i : i + m - 1));
    R(i) = preamble_temp * a_cumu(i : i + m - 1)' / mean_current;
end

figure;
plot(1 : length(R), R, 'color', 'k', 'linewidth', 1.5);
title('������⣨������� + ������ۻ���');
xlabel('Time');
ylabel('Amplitude');
axis([1 length(R) min(R) max(R)]);
set(gcf, 'position', [0, scrsz(4)/1.7, scrsz(3), scrsz(4)/3]);
set(gca, 'box', 'off', 'xtick', [], 'ytick', linspace(min(R), max(R), 6), 'fontsize', 13);
grid off;
set(gca, 'gridlinestyle', ':', 'gridcolor', 'k', 'gridalpha', 0.5);