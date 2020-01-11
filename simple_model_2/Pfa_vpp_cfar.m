format long;
clear, clc;
close all;

r1 = 44; % ѡ��������Ϊ 22M

% --- �龯����

figure;
hold on;

plot([-8 -7 -6 -5 ... 
    -4 -3 -2 -1 ...
    0 1 2 3 4 ...
    5],...
    log10([0.1572 0.1337 0.1109 0.0894 ...
    0.0697 0.0522 0.0374 0.0254 ...
    0.0162 0.0096 0.0053 0.0027 0.0014 ... 
    7.9617e-4]),...
    '-s', 'color', 'r', 'linewidth', 1.1, 'markersize', 3);

SNRdB = -8 : 1 : 5;
SNR = 10.^(SNRdB/10);
Pfa2 = 1 - normcdf(sqrt(r1)/2*sqrt(SNR));
Pfa2 = log10(Pfa2);
plot(SNRdB, Pfa2, '-o', 'color', [60/255 179/255 113/255], 'linewidth', 1.1, 'markersize', 3);

Pfa = 10^-4;
Pfa = log10(Pfa);
plot([-8 5], [Pfa Pfa], '--', 'color', 'b', 'linewidth', 1.1, 'markersize', 3);

Pfa = 10^-8;
Pfa = log10(Pfa);
plot([-8 5], [Pfa Pfa], '-', 'color', 'm', 'linewidth', 1.1, 'markersize', 5);

leg = legend('����λ�ü��', '3dB���޼��', '$P_{fa}=10^{-4}$ (CFAR)', '$P_{fa}=10^{-8}$ (CFAR)');
set(leg, 'location', 'best', 'interpreter', 'latex', 'box', 'off', 'fontname', 'Euclid');

% --- ���û�ͼ����
set(gcf, 'units', 'centimeters', 'Position', [12 12 6 4]);%����ͼƬ��СΪ 6cm��6cm

set(gca, 'xtick', [-8 -6 -4 -2 0 2 4 6]);
set(gca, 'ytick', [-8 -6 -4 -2 0]);
set(gca, 'yticklabel',{'10^{-8}', '10^{-6}', '10^{-4}', '10^{-2}', '1'});

xlabel('${\rm SNR} ( {\rm dB} )$', 'interpreter', 'latex');
ylabel('$P_{fa}$', 'interpreter', 'latex');
set(get(gca, 'xlabel'), 'fontsize', 7, 'fontname', 'euclid'); % �������ǩ
set(get(gca, 'ylabel'), 'fontsize', 7, 'fontname', 'euclid'); % �������ǩ
set(gca, 'fontsize', 7, 'fontname', 'euclid'); % ������
set(gca, 'linewidth', 0.5); % �������ߴ�0.5��
set(gca, 'box', 'on');
set(get(gca,'Children'), 'linewidth', 0.5); %����ͼ���߿�0.5��

axis([-8 6 -9 0]);
grid on;
set(gca, 'gridlinestyle', ':', 'GridColor', 'k', 'gridalpha', 1);















