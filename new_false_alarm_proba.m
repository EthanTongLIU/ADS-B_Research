%% ����ʦ�޸ĺ�汾���龯�����������޵Ĺ�ϵ

format long;
clear, clc;
close all;

figure;
hold on;
xlabel('Threshold \beta_{1}');
ylabel('Pfa');

% �����龯��

for r1 = 10 : 20 : 80 % ��������

Pfa = linspace(10e-1, 10e-7, 1000);
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
plot(beta1, Pfa, 'color', 'b');

end

% �����龯��