time_delay_in_seconds = 1
K = [39 31.5 24 16.5 9 1.5]

num = pade(time_delay_in_seconds, 2)
den = conv([1 1], conv([30 1], conv([1/9 1/3 1], [1 6 12])))
figure(1)
hold on
for k = 1:length(K)
    sys = tf(num * K(k), den)
    margin(sys)
end
legend(arrayfun(@(x) sprintf('K=%.1f', x), K, 'UniformOutput', false))
grid on

