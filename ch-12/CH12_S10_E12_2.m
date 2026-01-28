figure(3);clc; clf; hold on;

a=16; b=70;
K_var = 118;

KD = K_var - 2
KP = a * (2 + KD) - 1
KI = b * (2 + KD)

K = 5;
sys_gc = tf(K*[KD KP KI], [1 0])
C0 = 0.1:0.5:10.1
for i = 1:length(C0)
    c0 = C0(i)
    sys_g = tf(1, [1 2*c0 c0^2]);
    sys_l = sys_gc * sys_g;
    sys = feedback(sys_l, 1)
    step(sys)
    info = stepinfo(sys);
    if i == 1
        infos = repmat(info, numel(C0), 1);
    end
    infos(i) = info;
end

T = struct2table(infos);
T = addvars(T, C0(:), 'Before', 1, 'NewVariableNames', 'c0');
disp(T)
legend_c0 = arrayfun(@(x) sprintf('c0=%.2f', x), C0, 'UniformOutput', false);
title('Unit step response for various c0'); xlabel('Time (s)'); ylabel('y(t)')
legend(legend_c0); grid on;
hold off;