clc; clf;
syms KD KP KI s;

sys_tf = (KD*s^2 + KP*s + KI) / (s^3 + (2+KD)*s^2 + (1+KP)*s + KI)

a = (1 + KP) / (2 + KD)
b = KI / (2 + KD)
K_var = KD + 2

% chosen to ensure locus travels past the s = -8 line
a=16; b=70;
sys = tf([1 a b], [1 0 0 0])
rlocus(sys)
[K_var, sys_poles] = rlocfind(sys)

KD = K_var - 2
KP = a * (2 + KD) - 1
KI = b * (2 + KD)

K = 1:.5:10
figure(2); clf; hold on;
for i = 1:length(K)
    K_i = K(i)
    sys_gc = tf(K_i*[KD KP KI], [1 0])
    sys_g = tf(1, [1 2 1])
    sys_l = sys_gc * sys_g
    sys_final = feedback(sys_l, 1);
    step(sys_final)
    info = stepinfo(sys_final);
    if i == 1
        infos = repmat(info, numel(K), 1);
    end
    infos(i) = info;
end

T = struct2table(infos);
T = addvars(T, K(:), 'Before', 1, 'NewVariableNames', 'K');
disp(T)
legend_K = arrayfun(@(x) sprintf('K=%.2f', x), K, 'UniformOutput', false);
title('Unit step response for various K'); xlabel('Time (s)'); ylabel('y(t)')
legend(legend_K); grid on;
hold off;

figure(3); clf;
