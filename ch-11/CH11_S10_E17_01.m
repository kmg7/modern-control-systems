clc;
PO = 0.04; % DS1
Ts = 2; % seconds DS2
crit = 2;
% w_n =
[zeta, wn] = designSpecs(PO, Ts, crit)

% K = 1; K1 = 1; K2 = 1; K3 = 1
syms K K1 K2 K3 s
A = [0 1 0; 0 -1 1; 0 0 -5]
B = [0; 0; K]

C = [K1 K2 K3]
H = A - B*C
sI = eye(3) * s
char_eq = collect(det(sI - H), s)
syms KK3
char_eq = subs(char_eq, K*K3, KK3)
char_eq = collect(char_eq, KK3)

char_eq = collect(char_eq, s) %#ok<*NASGU>

disp('---------------------------');
% I wanted to rewrite characteristic equation in a better shape before substiting anything
% s^3 + 6*s^2 = s * (s + 1) * (s + 5)
char_eq = (s * (s + 1) * (s + 5)) + KK3 * (s^2 + s*(K3 + K2)/K3 + K1/K3)
char_eq = char_eq / (s * (s + 1) * (s + 5))
char_eq = subs(char_eq, ((s * (s + 1) * (s + 5)) / (s * (s + 1) * (s + 5))), 1)

% we want to place zeros at s = -4, 2j in order to pull the locus to the left
desired_poles = [-4 + 2j, -4 - 2j]
desired_num = poly(desired_poles)

K3_1 = 1/20;
K2_1 = 8 * K3_1 - K3_1
K1_1 = 1
final_eq = subs(char_eq, K3, K3_1);
final_eq = subs(final_eq, K2, K2_1);
final_eq = subs(final_eq, K1, K1_1);

disp('---------------------------');

final_eq

function [zeta, wn] = designSpecs(PO, Ts, crit)
zeta = sqrt((log(PO))^2 / (pi^2 + (log(PO))^2)); % Calculate damping ratio from percent overshoot
C = log(100/crit); % Calculate settling time constant based on criterion
wn = C / (zeta * Ts); % Calculate natural frequency
end

