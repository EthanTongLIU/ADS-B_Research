%% 苏老师修改后版本的虚警概率与检测门限的关系

format long;
clear, clc;
close all;

figure;
hold on;
xlabel('Threshold \beta_{1}');
ylabel('Pfa');

% 理论虚警率

for r1 = 10 : 20 : 80 % 采样点数

Pfa = linspace(10e-1, 10e-7, 1000);
beta1 = sqrt(r1*(4-pi)/pi) * norminv(1-Pfa, 0, 1) + r1;
plot(beta1, Pfa, 'color', 'b');

end

% 仿真虚警率