% clear, clc;
close all;

figure;
hold on;

% --- ����ֵ

r1 = 44; % ��������������Ϊ 22M
r0 = 132; % 
r2 = r0 - r1;

SNR = linspace(0.1, 80, 1000); % ����ȣ�ԭʼ������ʽ
beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

% --- CFAR

Pfa = 10^-4;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-', 'color', [0 0 1], 'linewidth', 1.1, 'markersize', 3);

Pfa = 10^-8;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1, 'markersize', 3);

Pfa = 10^-12;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1, 'markersize', 4);

Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1, 'markersize', 3);

% CFAR ����

plot(SNRdBQ, fQ, '-', 'color', 'k', 'linewidth', 1.1, 'markersize', 3);

% --- VPP

plot([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15],...
    zeros(1, length([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15])),...
    ':+', 'color', 'k', 'linewidth', 1.1, 'markersize', 3);

% --- ���ֵ����

plot([-10 -7 -5 -2 0 2 5 10 15], [0.855 0.9287 0.9699 0.995 0.9994 1 1 1 1] - [0.85135 0.9286 0.9684 0.9954 0.99955 1 1 1 1], ':*', 'color', [1 0.5 0], 'linewidth', 1.1, 'markersize', 3);

leg = legend('$P_{fa} = 10^{-4}$ (CFAR)',...
    '$P_{fa} = 10^{-8}$ (CFAR)',...
    '$P_{fa} = 10^{-12}$ (CFAR)',...
    '$P_{fa} = 10^{-16}$ (CFAR)',...
    '��ͬ�龯�ʵļ�ֵ��',...
    '����λ�ü��',...
    '3dB���޼��');
% title(leg, '$P_{fa}$');
set(leg, 'location', 'best', 'interpreter', 'latex', 'box', 'off', 'fontname', 'Euclid');

% --- ���û�ͼ����
set(gcf, 'units', 'centimeters', 'Position', [12 12 6 4]);%����ͼƬ��СΪ 6cm��6cm

xlabel('${\rm SNR} ( {\rm dB} )$', 'interpreter', 'latex');
ylabel('$P_{d} - P_{e}$', 'interpreter', 'latex');
set(get(gca, 'xlabel'), 'fontsize', 7, 'fontname', 'euclid'); % �������ǩ
set(get(gca, 'ylabel'), 'fontsize', 7, 'fontname', 'euclid'); % �������ǩ
set(gca, 'fontsize', 7, 'fontname', 'euclid'); % ������
set(gca, 'linewidth', 0.5); % �������ߴ�0.5��
set(gca, 'box', 'on');
set(get(gca,'Children'), 'linewidth', 0.5); %����ͼ���߿�0.5��

axis([-10 15 -0.05 1]);
grid on;
set(gca, 'gridlinestyle', ':', 'GridColor', 'k', 'gridalpha', 1);




