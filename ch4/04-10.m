% System Sensitivity plot
K = 20; 
num = [1 1 0]; 
den = [1 12 K];
w = logspace(-1, 3, 200); 
s = w*i;

n = s.^2 + s;
d = s.^2 + 12*s + K;
S = n ./ d;

subplot(2 1 1), plot(real(S), imag(S))
title('System Sensitivity to Plant Variations')
xlabel('Real Part'); ylabel('Imaginary Part'), grid
subplot(2 1 2), loglog(w, abs(S),w,abs(S2))
xlabel('\omega (rad/sec)'); ylabel('Abs(S)'), grid
