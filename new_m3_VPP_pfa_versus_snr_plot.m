format long;
clear, clc;
close all;

r1 = 44; % 选定采样率为 22M

% --- 虚警概率

figure;
hold on;

beta1 = 60;
Pfa = 1 - normcdf((beta1 - r1)/sqrt(r1*(4-pi)/pi));
Pfa = log10(Pfa);
plot([-8 15], [Pfa Pfa], '--', 'color', 'b', 'linewidth', 1.3);

plot([-8 -7 -6 -5 ... 
    -4 -3 -2 -1 ...
    0 1 2 3 4 ...
    5 6 7 8 9 10 11 12 13 14 15],...
    log10([0.1572 0.1337 0.1109 0.0894 ...
    0.0697 0.0522 0.0374 0.0254 ...
    0.0162 0.0096 0.0053 0.0027 0.0014 ... 
    7.9617e-4 6.1862e-4 6.0936e-4 6.7405e-4 7.5449e-4...
    8.3718e-4 9.0326e-4 9.5197e-4 9.6724e-4 9.622e-4 9.3810e-4]),...
    '-s', 'color', 'r', 'linewidth', 1.3);

leg = legend('$\beta_1=60$ (CFAR)', '增强型脉冲位置检测');
set(leg, 'interpreter', 'latex');

set(gca, 'yticklabel',{'10^{-7}','10^{-6}', '10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'});

xlabel('$SNR / dB$', 'interpreter', 'latex');
ylabel('$P_{fa}$', 'interpreter', 'latex');
axis([-8 15 -7 0]);
grid on;