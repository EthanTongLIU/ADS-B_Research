format long;
clear, clc;
close all;

r1 = 44; % 选定采样率为 22M

% --- 虚警概率

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
    '-s', 'color', 'r', 'linewidth', 1.1);

SNRdB = -8 : 1 : 5;
SNR = 10.^(SNRdB/10);
Pfa2 = 1 - normcdf(sqrt(r1)/2*sqrt(SNR));
Pfa2 = log10(Pfa2);
plot(SNRdB, Pfa2, '-o', 'color', [60/255 179/255 113/255], 'linewidth', 1.1);

beta1 = 40;
Pfa = 1 - normcdf(sqrt(2/pi)/sqrt(r1)*beta1);
Pfa = log10(Pfa);
plot([-8 5], [Pfa Pfa], '--', 'color', 'b', 'linewidth', 1.1);

beta1 = 50;
Pfa = 1 - normcdf(sqrt(2/pi)/sqrt(r1)*beta1);
Pfa = log10(Pfa);
plot([-8 5], [Pfa Pfa], '-.', 'color', 'm', 'linewidth', 1.1);

% plot([-8 -7 -6 -5 ... 
%     -4 -3 -2 -1 ...
%     0 1 2 3 4 ...
%     5 6 7 8 9 10 11 12 13 14 15],...
%     log10([0.1572 0.1337 0.1109 0.0894 ...
%     0.0697 0.0522 0.0374 0.0254 ...
%     0.0162 0.0096 0.0053 0.0027 0.0014 ... 
%     7.9617e-4 6.1862e-4 6.0936e-4 6.7405e-4 7.5449e-4...
%     8.3718e-4 9.0326e-4 9.5197e-4 9.6724e-4 9.622e-4 9.3810e-4]),...
%     '-s', 'color', 'r', 'linewidth', 1.3);

leg = legend('脉冲位置检测', '固定门限匹配滤波', '$\beta_1=40$ (CFAR)', '$\beta_1=50$ (CFAR)');
set(leg, 'interpreter', 'latex');

set(gca, 'yticklabel',{'10^{-10}', '10^{-9}', '10^{-8}', '10^{-7}','10^{-6}', '10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'});

xlabel('${\rm SNR} / {\rm dB}$', 'interpreter', 'latex');
ylabel('$P_{fa}$', 'interpreter', 'latex');
axis([-8 6 -10 0]);
grid on;