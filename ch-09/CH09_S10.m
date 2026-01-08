sys = tf(0.5, [1 2 1 0.5])
figure(1)
nyquist(sys);
figure(2)
margin(sys);
figure(3)
nichols(sys)

figure(4)
sys2 = tf(1, [0.2 1.2 1 0])
w = logspace(-1, 1, 400);
nichols(sys2, w);