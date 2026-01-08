figure(6); clc; clf;
sys_g = tf(1, [1 15 50 0])

rlocus(sys_g); hold on;
zeta = 0.5912; wn = 2.2555;

x = -10 : 0.1 : -zeta*wn;
y = -(sqrt(1 - zeta^2) / zeta) * x;
xc = -10 : 0.1 : -zeta*wn;
c = sqrt(wn^2-xc.^2);

plot(x, y, '--', x, -y, '--', xc, c, '--', xc, -c, '--');
hold off;

figure(7); clf;
sys_gc = tf([1 0.1], [1 0.01])
sys = sys_gc * sys_g

rlocus(sys); hold on;

plot(x, y, '--', x, -y, '--', xc, c, '--', xc, -c, '--');
hold off;

figure(8); clf;
K = 100;
sys_gc_final = tf(K * [1 0.1], [1 0.01])
sys_final = feedback(sys_gc_final * sys_g, 1)

step(sys_final)
stepinfo(sys_final)