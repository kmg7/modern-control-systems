f = figure;
f.Name = 'E05.11-Step Response Comparison';

sys = tf([6], [1 6 11 6]);
sysApprox = tf([1.6], [1 2.59 1.6]);

t = 0:0.1:8;

[y1, T1] = step(sys, t);
[y2, T2] = step(sysApprox, t);

plot(T1, y1, 'DisplayName', 'Third-order system');
hold on

plot(T2, y2, '--', 'DisplayName', 'Second-order approx.');
hold off

xlabel('Time (s)')
ylabel('Step Response')
legend()
grid on
