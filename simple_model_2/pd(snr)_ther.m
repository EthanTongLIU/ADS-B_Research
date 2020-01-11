% 2. �̶�r1��SNR ��Ϊ����

clear, clc;
close all;

figure;
hold on;

% --- CFAR

r1 = 44; % ��������������Ϊ 22M

SNR = linspace(0.1, 30, 1000); % ����ȣ�ԭʼ������ʽ

Pfa = 10^-4;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-', 'color', [0 0 1], 'linewidth', 1.1, 'markersize', 3);

plot([-10 -8 -6 -4 -2 0 2], ...
    [0.0581 0.14715 0.35075 0.67495 0.92895 0.9981 1], ... 
    ':x', 'color', [0 0 1], 'markersize', 3);

Pfa = 10^-8;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '-.', 'color', [1 0 1], 'linewidth', 1.1, 'markersize', 3);

plot([-8 -6 -4 -3 -2 -1 0 1 2 3 4], ...
    [0.0027 0.0168 0.0889 0.1989 0.37515 0.6177 0.83485 0.9577 0.9944 0.9999 1], ... 
    ':s', 'color', [1 0 1], 'markersize', 3);

SNR = linspace(0.1, 30, 300); % ����ȣ�ԭʼ������ʽ

Pfa = 10^-12;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, ':.', 'color', [1 0 0], 'linewidth', 1.1, 'markersize', 5);

plot([-4 -3 -2 -1 0 1 2 3 4], ...
    [0.00505 0.0178 0.0542 0.1538 0.35925 0.6467 0.88555 0.98285 0.99935], ... 
    ':d', 'color', [1 0 0], 'markersize', 3);

Pfa = 10^-16;
beta1 = sqrt(pi/2*r1)*norminv(1-Pfa); % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
plot(10*log10(SNR), Pd, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1, 'markersize', 3);

plot([-2 -1 0 1 2 3 4 5 6], ...
    [0.0055 0.02055 0.08195 0.25 0.54755 0.84835 0.97805 0.9993 1], ... 
    ':o', 'color', [60/255 179/255 113/255], 'markersize', 3);

% --- VPP

plot([-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15],...
    [0.4898 0.4204 0.3589 0.2957 0.247 0.2014 0.1686 0.151 0.1348 0.1356 0.1484...
    0.1679 0.209 0.269 0.3568 0.4731 0.6 0.7317 0.8388 0.9218 0.9678 0.9901 0.9964 0.9993],...
    ':+', 'color', 'k', 'linewidth', 1.1, 'markersize', 3);

% --- ���ֵ����

plot([-10 -7 -5 -2 0 2 5 10 15], [0.855 0.9287 0.9699 0.995 0.9994 1 1 1 1], ':*', 'color', [1 0.5 0], 'linewidth', 1.1, 'markersize', 3);

% leg = legend('$P_{fa} = 10^{-4}$ (theoretic)',...
%     '$P_{fa} = 10^{-4}$ (simu)',...
%     '$P_{fa} = 10^{-8}$ (theoretic)',...
%     '$P_{fa} = 10^{-8}$ (simu)',...
%     '$P_{fa} = 10^{-12}$ (theoretic)',...
%     '$P_{fa} = 10^{-12}$ (simu)',...
%     '$P_{fa} = 10^{-16}$ (theoretic)',...
%     '$P_{fa} = 10^{-16}$ (simu)',...
%     'VPP',...
%     '3dB');

% leg = legend('$P_{fa} = 10^{-4}$',...
%     '$P_{fa} = 10^{-4}$',...
%     '$P_{fa} = 10^{-8}$',...
%     '$P_{fa} = 10^{-8}$',...
%     '$P_{fa} = 10^{-12}$',...
%     '$P_{fa} = 10^{-12}$',...
%     '$P_{fa} = 10^{-16}$',...
%     '$P_{fa} = 10^{-16}$',...
%     'VPP',...
%     '3dB');
% title(leg, '$P_{fa}$');
% set(leg, 'location', 'best', 'interpreter', 'latex', 'box', 'off', 'fontname', 'Euclid');

% set(gca,'Position',[.18 .18 .75 .70]);%����xy����ͼƬ��ռ�ı���

% --- ���û�ͼ����
set(gcf, 'units', 'centimeters', 'Position', [12 12 6 4]);%����ͼƬ��СΪ 6cm��6cm

xlabel('${\rm SNR} ( {\rm dB} )$', 'interpreter', 'latex');
ylabel('$P_{d}$', 'interpreter', 'latex');
set(get(gca, 'xlabel'), 'fontsize', 7, 'fontname', 'euclid'); % �������ǩ
set(get(gca, 'ylabel'), 'fontsize', 7, 'fontname', 'euclid'); % �������ǩ
set(gca, 'fontsize', 7, 'fontname', 'euclid'); % ������
set(gca, 'linewidth', 0.5); % �������ߴ�0.5��
set(gca, 'box', 'on');
set(get(gca,'Children'), 'linewidth', 0.5); %����ͼ���߿�0.5��

axis([-10 15 0 1]);
% set(gca, 'fontsize', 7, 'fontname', 'Euclid');
grid on;
set(gca, 'gridlinestyle', ':', 'GridColor', 'k', 'gridalpha', 1);











