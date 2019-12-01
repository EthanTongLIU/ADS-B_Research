clear, clc;
close all;

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 
r2 = r0 - r1;

SNR = -10:0.5:10; % dB
SNR = power(10, SNR / 10); % 信噪比，原始比例形式

beta2 = ( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;

Pd = @(beta1)1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
Pe = @(beta1)1 - normcdf(beta1 .* beta2 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 

A = 2/(pi*r1).*(beta2.^2-1);
B = 2*sqrt(2/(pi*r1))*sqrt(r1)*sqrt(SNR).*(1-beta2);
C = -2*log(beta2);

beta1Q = (-B+sqrt(B.^2-4*A.*C))./(2*A);
fQ = Pd(beta1Q) - Pe(beta1Q);

plot(beta1Q, fQ, '-o');
grid on;

figure;
plot(10*log10(SNR), fQ, '-s');
grid on;

figure;
plot(10*log10(SNR), beta1Q, ':o');
grid on;