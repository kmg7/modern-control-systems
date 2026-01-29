figure(2)
Ts = 1;
sysg = tf(0.3678 * [1 0.7189], conv([1 -1], [1 -0.3680]), Ts)
sysgc = tf([1 -0.3678], [1 0.2400], Ts)
sysl = sysg * sysgc
rlocus(sysl);