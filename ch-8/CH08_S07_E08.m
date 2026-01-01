% engraving machine system example
K=2
plant = tf(1, [conv([1 0], conv([1 1], [1 2]))])
sys = feedback(K * plant, 1)

figure(1);
bode(sys)

figure(2);
rlocus(sys)

figure(3);
pzmap(sys)

figure(4);
t = 0:0.01:20;
y = step(sys, t);
plot(t, y); grid, xlabel('Time(s)'), ylabel('y(t)')
stepinfo(sys)

w = logspace(-1, 1, 400);
[mag, phase, w] = bode(sys, w);
[mp, l] = max(mag);
wr = w(l);

zet = (0.5 * (1 - (1 -1/mp^2)^(1/2)))^(1/2)
wn = wr / (1 -2*zet^2)^(1/2)

ts = 4/zet/wn
po = 100*exp(-zet*pi/(1-zet^2)^(1/2))