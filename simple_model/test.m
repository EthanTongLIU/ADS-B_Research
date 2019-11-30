clear, clc;
close all;

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 
r2 = r0 - r1;

SNR = 0.01 : 0.001 : 30;
SNRdB = 10*log10(SNR);

beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

plot(SNRdB, beta2);
grid on;