%% Section 7.10 Disk Drive Read System Root Locus Analysis
%#ok<*NOPRT,*ASGLU,*DEFNU,*NASGU>

sketchRootLocus(1);

function sys = getSys(Kp, Kd)
sys_gc = tf([Kd Kp], 1);              % PD controller
sys_gi = tf(5000, [1 1000]);          % Motor coil with integrator
sys_p = tf(1, conv([1 0], [1 20]));   % Plant

sys = feedback(sys_gc * sys_gi * sys_p, 1);  % Unity feedback
end

function sketchRootLocus(z)
num = 5000 * [1 z];
den = conv([1 0], conv([1 20], [1 1000]));

sys = tf(num, den);

% Generate and display root locus
figure;
rlocus(sys);
rlocfind(sys);

% Calculate and display pole/zero information
p = pole(sys);
z = zero(sys);

% Calculate asymptote centroid (should be at +/- 90 degrees)
centroid = (sum(p) - sum(z)) / (length(p) - length(z))
end


function expandDenominator()
syms s
expr = s * (s + 20) * (s + 1000);
expand(expr);
end