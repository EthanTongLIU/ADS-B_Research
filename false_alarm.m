clear, clc;
close all;

x = linspace(0, 3, 10000);

H = 2 - pi / 2.0;
K = 0.6;
N = 100;

u1 = sqrt(pi / 2) * K;
d1 = H * K .^ 2 / N;

u2 = sqrt(pi / 2);
d2 = 4 * H / N;

f1 = 1.0 / sqrt(2 * pi * d1) * exp(-(x - u1) .^ 2 / (2 * d1));
f2 = 1.0 / sqrt(2 * pi * d2) * exp(-(x - u2) .^ 2 / (2 * d2));

plot(x, f1, 'color', 'r');
hold on;
plot(x, f2, 'color', 'b');
legend('f(u^{\prime})', 'f(u^{\prime\prime})');

% f3 = 1.0 / sqrt(2 * pi) * sqrt(N / (4 * H)) * exp(- N * x .^2 / (8 * H));
% figure;
% plot(x, f3);

figure;
x0 = 0.1;
for j = 1 : 5
  N = 5;
  q = zeros(1, 200);
  for i = 1 : 200
    fun = @(y) 1 / sqrt(2 * pi) * sqrt(N / (4 * H)) * exp( - N * y .^ 2 / (8 * H) );
    q(i) = integral(fun, x0, 10000);
    N = N + 5;
  end
  plot(5 : 5 : 1000, q);
  hold on;
  x0 = x0 + 0.1;
end
