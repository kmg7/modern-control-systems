sysc = tf(1, [1 1 0])
sysd = c2d(sysc, 1)
sys = feedback(sysd, 1)
T = 0:1:25;
step(sys, T)