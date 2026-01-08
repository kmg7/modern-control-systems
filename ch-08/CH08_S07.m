num = 5 * [0.1 1];
den = conv([1 0], conv([0.5 1], [1/(50^2) 0.6/50 1 ]))
% den = conv([0.5 1], [1/(50^2) 0.6/50 1 ])

% syms s
% expr = (5 * (0.1*s + 1)) / (s * (1 + 0.5*s) * (1 + (0.6/50)*s + (1/(50^2))*s^2));
% expand(expr)

sys = tf(num, den)

figure;
pzmap(sys)
sys_poles = pole(sys)
sys_zeros = zero(sys)
figure;
bode(sys)


zeta = 0.15:0.01:0.7;
wr_over_wn = sqrt(1-2*zeta.^2);
Mp = (2*zeta .*sqrt(1-zeta.^2)).^(-1);

figure;
subplot(211)
plot(zeta, Mp)
grid
xlabel('\zeta')
ylabel('M_{p\omega}')

subplot(212)
plot(zeta, wr_over_wn)
grid
xlabel('\zeta')
ylabel('\omega_r / \omega_n')
