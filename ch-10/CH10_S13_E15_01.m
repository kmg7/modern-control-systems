% example for rotor winder control system

K = [50 100 200 500];
sys_g = tf(1, [1 15 50 0])

t = 0:0.01:5;
Ys = zeros(length(t), length(K));

for i = 1:length(K)
    k = K(i)
    sys = feedback(k * sys_g, 1)
    y = step(sys, t);
    info = stepinfo(sys);
    Ys(:, i) = y;
    if i == 1
        infos = repmat(info, numel(K), 1);
    end
    infos(i) = info;
end

% Tabulate step info for each K (simple table output)
T = struct2table(infos);
T = addvars(T, K(:), 'Before', 1, 'NewVariableNames', 'K');
disp(T)

legend_K = arrayfun(@(x) sprintf('K=%.2f', x), K, 'UniformOutput', false);

figure(1); clf reset; hold on;
for i = 1:length(K)
    plot(t, Ys(:, i))
end
title('Unit step response for various K'); xlabel('Time (s)'); ylabel('y(t)')
legend(legend_K); grid on;

