% example 14 Liquid control system analysis

unitStepSteadyStateError(20)
unitStepSteadyStateError(10)

w = logspace(-1, 1, 200);
t = 0:0.01:10;
K = [30 20 10 4.44 2 1];

legend_K = arrayfun(@(x) sprintf('K=%.2f', x), K, 'UniformOutput', false);
y = zeros(length(t), length(K))

sysgc = tf([1 2], [1 1])
sysg = tf(1, [1 2 4])
sysl = sysgc * sysg
figure(1); clf reset; hold on;

for i = 1:length(K)
    k = K(i)
    sys = feedback(k * sysl, 1)
    bode(sys, w)
    y(:, i) = step(sys, t);
end
legend(legend_K); grid on;


figure(2); hold on;
for i = 1:length(K)
    plot(t, y(:, i))
end
title('Unit step response for various K'); xlabel('Time (s)'); ylabel('y(t)')
legend(legend_K); grid on;

figure(3); clf reset; hold on;
for i = 1:length(K)
    k = K(i);
    nichols(k * sysl)
end
legend(legend_K); grid on;

sys_k10 = 10 * sysl
figure(4);
margin(sys_k10)

figure(5);
nyquist(sys_k10)


function ess = unitStepSteadyStateError(K)
ess = 1 / (1 + K/2);
end