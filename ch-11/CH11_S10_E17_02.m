% final_eq = (KK3*(s^2 + 8*s + 20) + s*(s + 1)*(s + 5))/(s*(s + 1)*(s + 5))
clc;
figure(1); clf;
% expand(s*(s + 1)*(s + 5))

sys = tf([1 8 20], [1 6 5 0])
rlocus(sys)
hold on;
zeta = 0.7156; wn = 2.7332;

x = -10 : 0.1 : -zeta*wn;
xc = x;
y = -(sqrt(1 - zeta^2) / zeta) * x;
c = sqrt(wn^2-xc.^2);

plot(x, y, '--', x, -y, '--', xc, c, '--', xc, -c, '--');
rlocfind(sys);
hold off;
KK3 = 12 / (1/20)

figure(2); clf;
K = 240; K1 = 1; K2 = 0.35; K3 = 0.05;

A = [0 1 0; 0 -1 1; -K*K1 -K*K2 -(5+K*K3)];
B = [0; 0; K]
C = [1 0 0]; D = 0;
sys_final = ss(A, B, C, D)
step(sys_final)