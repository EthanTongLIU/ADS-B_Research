clear, clc;
close all;

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 
r2 = r0 - r1;

SNR = 0.01 : 0.01 : 80;
SNRdB = 10*log10(SNR);

beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

figure;
plot(SNRdB, beta2, 'color', 'b', 'linewidth', 1.1);
xlabel('${\rm SNR}/{\rm dB}$', 'interpreter', 'latex');
ylabel('$\beta_{2}$', 'interpreter', 'latex');
grid on;