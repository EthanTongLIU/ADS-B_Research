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

% ------------------------------

beta1 = 40; % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-', 'color', [0 0 1], 'linewidth', 1.1);

% ------------------------------

beta1 = 60; % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '-.', 'color', [1 0 1], 'linewidth', 1.1);

% ------------------------------

beta1 = 80; % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, ':.', 'color', [1 0 0], 'linewidth', 1.1);

% ------------------------------

beta1 = 100; % �������
Pd = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR));
Pe = 1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
plot(10*log10(SNR), Pd - Pe, '--', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

% --------------------------------
% ��������

plot(SNRdBQ, fQ, ':', 'color', 'k', 'linewidth', 1.1);

% --------------------------------

leg = legend('$\beta_{1} = 40$', '$\beta_{1} = 60$', '$\beta_{1} = 80$', '$\beta_{1} = 100$', '����');
% title(leg, '\beta_{1}');
set(leg, 'location', 'northwest', 'interpreter', 'latex');

xlabel('${\rm SNR} / {\rm dB}$', 'interpreter', 'latex');
ylabel('$P_{d} - P_{e}$', 'interpreter', 'latex');
grid on;




