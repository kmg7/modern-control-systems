Ka = 100; K1 = 0.05;
sys1 = tf(5000, [1 1000]);
sys2 = tf(1, [1 20 0]);
sysc = tf([K1 1], [0 1]);
syso = Ka*sys1*sys2;

sys = minreal(feedback(syso, sysc));

t = 0:0.001:0.5;
y = step(sys, t);
figure;
plot(t, y);
xlabel('Time (s)');
ylabel('y(t) step response');
grid on;
