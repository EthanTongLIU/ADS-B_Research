% ����ʦ�޸ĺ�İ汾�ļ�����

format long;
clear, clc;
close all;

% ���ۼ�����

%% 1. �̶� r1��beta1 ��Ϊ����

figure;
hold on;

r1 = 44; % ��������ѡ��������Ϊ 22M

SNR = 0.1;
beta1 = linspace(0, 140, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', [0 0 1]);

SNR = 0.5;
beta1 = linspace(0, 140, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', [1 0 0]);

SNR = 1;
beta1 = linspace(0, 140, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', [1 0.65 0]);

SNR = 3;
beta1 = linspace(0, 140, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', 'm');

SNR = 10;
beta1 = linspace(0, 140, 100); % �������
Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
plot(beta1, Pd, 'color', 'g');

xlabel('Threshold \beta_{1}');
ylabel('P_{d}');
grid on;

%% 2. �̶�r1��SNR ��Ϊ����

figure;
hold on;
xlabel('SNR');
ylabel('P_{d}');

r1 = 30; % ������

for beta1 = 20 : 10 : 60 % �������
    SNR = linspace(0.1, 20, 100); % ����ȣ�ԭʼ������ʽ
    Pd = 1 - normcdf(beta1 .* sqrt(pi/(2*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(SNR, Pd, 'color', 'r');
end

%% 3. �̶� beta1��r1 ��Ϊ����

figure;
hold on;
xlabel('r1');
ylabel('P_{d}');

beta1 = 60; % �������

for SNR = 1 : 2 : 10
    r1 = linspace(10, 200, 200); % ��������
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(r1, Pd, 'color', 'r');
end

%% 4. �̶� beta1��SNR ��Ϊ����

figure;
hold on;
xlabel('SNR');
ylabel('P_{d}');

beta1 = 50; % �������

for r1 = 10 : 50 : 200
    SNR = linspace(0.1, 20, 100); % ��������
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(SNR, Pd, 'color', 'r');
end

%% 5. �̶� SNR��beta1 ��Ϊ����

figure;
hold on;
xlabel('beta1');
ylabel('P_{d}');

SNR = 0.5; % ����ȣ�ԭʼ������ʽ

for r1 = 10 : 20 : 100
    beta1 = linspace(0.1, 70, 100); % ��������
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(beta1, Pd, 'color', 'r');
end

%% 6. �̶� SNR��r1 ��Ϊ����

figure;
hold on;
xlabel('r1');
ylabel('P_{d}');

SNR = 1; % ����ȣ�ԭʼ������ʽ

for beta1 = 10 : 10 : 70
    r1 = linspace(10, 200, 100); % ��������
    Pd = 1 - normcdf(beta1 .* sqrt(pi./(2.*r1)) - sqrt(r1) .* sqrt(SNR));
    plot(r1, Pd, 'color', 'r');
end

% ���������

% ���� Pfa �� Pd ֮��ϵ

















