% Matlab FFT Ƶ�׷�������

clear, clc;
close all;

% һ�� FFT Ƶ�׷�������

% ����Ƶ�ʷֱ�Ϊ15Hz��20Hz�������ź�

Fs = 50; % ������
f1 = 15;
f2 = 20;
t = 0:1/Fs:10-1/Fs; % 500����
x = sin(2*pi*f1*t) + sin(2*pi*f2*t);
figure;
plot(t, x);
y = fft(x);
% ��������ת������ʾΪƵ��f=n*(fs/N)
f = (0:length(y)-1)*Fs/length(y);

% 

figure;
plot(f, abs(y));
title('Magnitude');

% Ϊ�˸��õ��Կ��ӻ���ʽ���������ԣ�����ʹ��fftshift�����Ա任ִ������Ϊ���ĵ�ѭ��ƽ��
n = length(x);
fshift = (-n/2:n/2-1)*(Fs/n);
yshift = fftshift(y);
figure;
plot(fshift, abs(yshift));