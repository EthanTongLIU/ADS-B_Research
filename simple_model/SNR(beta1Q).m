clear, clc;
close all;

r1 = 44; % 样本数，选定采样率为 22M
r0 = 132; % 
r2 = r0 - r1;


i = 1;
for beta1 = 10 : 100

beta2 = @(SNR)( exp(-SNR/2) + sqrt(pi/2)*sqrt(SNR).*(1-2*normcdf(-sqrt(SNR))) ) * r1/r0 + r2/r0;
Pd = @(SNR)1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 
Pe = @(SNR)1 - normcdf(beta1 .* beta2(SNR) .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(SNR)); 

syms x
f(x) = 1 - normcdf(beta1 .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(x));
h(x) = ( exp(-x/2) + sqrt(pi/2)*sqrt(x).*(1-2*normcdf(-sqrt(x))) ) * r1/r0 + r2/r0;
g(x) = 1 - normcdf(beta1 .* h(x) .* sqrt(2/(pi*r1)) - sqrt(r1) .* sqrt(x));

q(x) = diff(f(x)-g(x));

fun = str2func(['@(x)',vectorize(q)]);

SNRdB = -10 : 0.1 : 10; % dB
SNR = power(10, SNRdB / 10); % 信噪比，原始比例形式

% plot(SNRdB, fun(SNR));
% grid on;

for k = 2 : length(SNR)-1 
    if(fun(SNR(k-1)) > 0 && fun(SNR(k)) < 0)
        if abs(fun(SNR(k-1))) < abs(fun(SNR(k)))
            SNRdBQ(i) = SNRdB(k-1);
            SNRQ(i) = SNR(k-1);
            fQ(i) = Pd(SNRQ(i)) - Pe(SNRQ(i));
            i = i + 1;
        else
            SNRdBQ(i) = SNRdB(k);
            SNRQ(i) = SNR(k-1);
            fQ(i) = Pd(SNRQ(i)) - Pe(SNRQ(i));
            i = i + 1;
        end
    end
end

end

% plot(beta1Q, fQ, 'color', 'b', 'linewidth', 1.1);
% xlabel('${\beta_{1}}_{Q}$', 'interpreter', 'latex');
% ylabel('$P_{d}-P_{e}$', 'interpreter', 'latex');
% grid on;
% 
% % figure;
% % plot(10*log10(SNR), fQ, '-s');
% % grid on;
% 
% figure;
% plot(10*log10(SNR), beta1Q, 'color', 'b', 'linewidth', 1.1);
% xlabel('${\rm SNR}/{\rm dB}$', 'interpreter', 'latex');
% ylabel('${\beta_{1}}_{Q}$', 'interpreter', 'latex');
% grid on;