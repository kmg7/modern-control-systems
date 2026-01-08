%#ok<*NOPRT,*ASGLU,*DEFNU,*NASGU>
K = findRootsAndK();
% K = 20.5775;
partialFractionExpansionOfEquation(K);
stepResponse(K);
sensitivityAnalysis(K);

function K = findRootsAndK()
figure;
p = [1 1]; q = [1 5 6 0];
sys = tf(p,q);
% [roots, K] = rlocus(sys)
rlocus(sys);
K = rlocfind(sys)
end

function partialFractionExpansionOfEquation(K)
num = K * [1 4 3];
den = [1 5 6+K K 0];
[residues, poles, directTerm] = residue(num, den)
[num2, den2] = residue(residues, poles, directTerm); % we can get back original num and den
end

function stepResponse(K)
figure;
num = K * [1 4 3];
den = [1 5 6+K K];
sys = tf(num, den);
step(sys)
end

function sensitivityAnalysis(K)
den = [1 5 6+K K];
r1 = roots(den);
dK = K * 0.05;
Km = K + dK;
denm = [1 5 6+Km Km];
r2 = roots(denm);
dr = r1 - r2;
Sensitivity = dr / (dK / K)
end