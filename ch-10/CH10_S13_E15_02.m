figure(2); clf reset;
k = 500; % selected

sys_uncompansated = k * sys_g
[Gm, Pm, Wcg, Wcp] = margin(sys_uncompansated)
[mag, phase, w] = bode(sys_uncompansated); % Step 1: Obtain the uncompensated system Bode plot and compute the phase margin.

Phi = (60 - Pm) * pi / 180 % Step 2: Determine the amount of necessary phase lead
alpha = (1 + sin(Phi)) / (1 - sin(Phi)) % Step 3: Evaluate αlpha
mag_save(1, :) = mag(:, 1, :);

% Step 4: Compute -10 log alpha and find frequency w_m on the uncompensated Bode plot
M_target = -10 * log10(alpha); % -10 log alpha value
M = M_target * ones(length(w), 1); % -10 log alpha to aid in location of w_m
mag_dB = 20 * log10(mag_save);

% Find the frequency where magnitude equals -10 log alpha
% Convert magnitude to dB and find intersection
[~, idx] = min(abs(mag_dB - M_target)); % Find closest point to the target magnitude
w_m = w(idx) % Frequency at this point

semilogx(w, mag_dB, 'b-'); hold on;
semilogx(w, M, 'r--');

plot(w_m, M_target, 'go', 'MarkerSize', 5); % '\omega_m intersection point'

plot(w_m, 0, 'go', 'MarkerSize', 5); % 'the 0-dB point at \omega_m'
w_m_plus20 = w_m + 20;
plot(w_m_plus20, M_target, 'go', 'MarkerSize', 5); % '\omega_m plus 20 dB point'

% Draw a line through the 0-dB point at w_m and w_m_plus20
% Line equation: mag = (M_target - 0) / log10(w_m_plus20/w_m) * log10(w/w_m)
line_slope = M_target / log10(w_m_plus20 / w_m); % slope in dB per decade
mag_line = line_slope * log10(w / w_m); % line through (w_m, 0)

% Locate the frequency where the uncompensated magnitude meets the clipped lead line
[~, idx_eq] = min(abs(mag_dB(:) - mag_line_clipped(:)));
w_instersetion = w(idx_eq);
mag_intersetion = mag_dB(idx_eq);

mag_line_clipped = max(mag_line, M_target); % clip so line never exceeds magnitude at w_m_plus20
mag_line_clipped = min(mag_line_clipped, mag_intersetion);
plot(w, mag_line_clipped, 'r-'); % Draw the compensated lead line

plot(w_instersetion, mag_intersetion, 'go', 'MarkerSize', 5);
grid on; xlabel('Freq (rad/s)'); ylabel('Magnitude (dB)')
legend('Uncompensated Bode plot', '-10 log(\alpha)', '\omega_m intersection point', 'the 0-dB point at \omega_m', '\omega_m plus 20 dB point', 'Lead line (clipped)', 'Intersection with lead line')

