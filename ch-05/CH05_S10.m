function stepResponse
figure;

num = [1];

zeta1 = 0.1; den1 = [1 2*zeta1 1]; sys1 = tf(num, den1);
zeta2 = 0.2; den2 = [1 2*zeta2 1]; sys2 = tf(num, den2);
zeta3 = 0.4; den3 = [1 2*zeta3 1]; sys3 = tf(num, den3);
zeta4 = 0.7; den4 = [1 2*zeta4 1]; sys4 = tf(num, den4);
zeta5 = 1.0; den5 = [1 2*zeta5 1]; sys5 = tf(num, den5);
zeta6 = 2.0; den6 = [1 2*zeta6 1]; sys6 = tf(num, den6);

t = 0:0.1:12; 
[y1,T1] = step(sys1,t);
[y2,T2] = step(sys2,t);
[y3,T3] = step(sys3,t);
[y4,T4] = step(sys4,t);
[y5,T5] = step(sys5,t);
[y6,T6] = step(sys6,t);

plot(T1,y1,T2,y2,T3,y3,T4,y4,T5,y5,T6,y6)
xlabel('\omega_n t')
ylabel('y(t)')
title('\zeta = 0.1, 0.2, 0.4, 0.7, 1.0, 2.0')
grid on
end

function impulseResponse
figure;

num = [1];

zeta1 = 0.1;  den1 = [1 2*zeta1 1]; sys1 = tf(num, den1);
zeta2 = 0.25; den2 = [1 2*zeta2 1]; sys2 = tf(num, den2);
zeta3 = 0.5;  den3 = [1 2*zeta3 1]; sys3 = tf(num, den3);
zeta4 = 1.0;  den4 = [1 2*zeta4 1]; sys4 = tf(num, den4);

t = 0:0.1:10; 
[y1,T1] = impulse(sys1,t);
[y2,T2] = impulse(sys2,t);
[y3,T3] = impulse(sys3,t);
[y4,T4] = impulse(sys4,t);

plot(T1,y1,T2,y2,T3,y3,T4,y4)
xlabel('\omega_n t')
ylabel('y(t)')
title('\zeta = 0.1, 0.25, 0.5, 1.0')
grid on
end

function transientResponse
figure;

numg = [10 20]; deng = [1 10 0]; sysg = tf(numg, deng);
[sys] = feedback(sysg, [1]);

v1 = [0:0.1:2]'; 
v2 = [2:-0.1:-2]';
v3 = [-2:0.1:0]';

u = [v1; v2; v3];
t = [0:0.1:8.2]';

[y,T] = lsim(sys, u, t);
plot(T, y, t, u, '--')
xlabel('Time (s)')
ylabel('\theta (rad)')
grid on
end

stepResponse;
impulseResponse;
transientResponse;