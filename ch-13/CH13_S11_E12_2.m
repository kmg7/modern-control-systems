sysg = tf(1, [1 1 0]);

[nd, dd] = pade(1, 2);
sysp = tf(nd, dd)

sysi = tf(1, [1 0])
sys1 = (1-sysp) * sysi

syso = sys1 * sysg

sys = feedback(syso, 1)
t = 0:0.1:20;
step(sys, t); grid on;