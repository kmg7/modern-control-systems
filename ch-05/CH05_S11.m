unitStepInput(15:15:75)
unitStepDisturbance(15:15:75)

function unitStepInput(KaArray)

figure('Name','S05.11 - Response of the system to a unit step input')
hold on

sysg = tf(1, [1 20 0]);
t = 0:0.01:1;

for Ka = KaArray
    sysc = tf(Ka*5, 1);
    sys  = feedback(series(sysc, sysg), 1);

    y = step(sys, t);

    plot(t, y, 'DisplayName', sprintf('K_a = %.2g', Ka))
end

hold off
xlabel('Time (s)')
ylabel('y(t)')
legend
grid on

end


function unitStepDisturbance(KaArray)

figure('Name','S05.11 - Response of the system to a unit step disturbance')
hold on

sysg = tf(1, [1 20 0]);
t = 0:0.01:1;

for Ka = KaArray
    sysc = tf(Ka*5, 1);
    sys  = feedback(sysg, sysc);
    sys = -sys;
    y = step(sys, t);

    plot(t, y, 'DisplayName', sprintf('K_a = %.2g', Ka))
end

hold off
xlabel('Time (s)')
ylabel('y(t)')
legend
grid on

end
