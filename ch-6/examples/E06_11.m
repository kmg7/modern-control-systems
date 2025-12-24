% E06_11.m
% Example 6.11: Two Track vehicle turning control
rootLocs()
stabilityRegion()
rampResponses([0.5, 50; 0.6, 70; 0.8, 90; 1, 110]);

K = 70; a = 0.6;
sys = getSystem(a, K);
figure;
pole(sys)
pzmap(sys);

% Verify eigenvalues of A matrix
A = [-8 -16 -6; 1 0 0; 0 1 0];
eig(A)

function rootLocs()
figure;

K = 0:0.5:20;
p = zeros(3, length(K));  % Preallocate for 3 roots × number of K values
for i = 1:length(K)
    k = K(i);
    q = [1 2 4 k];
    p(:,i) = roots(q);
end

plot(real(p), imag(p), 'x');
xlabel('Real Part');
ylabel('Imaginary Part');
grid on;

end

function stabilityRegion()
figure;

a = 0.1:0.01:3;
K = 20:1:120;

x = zeros(length(K));
y = zeros(length(K));
n = length(K);
m = length(a);

for i = 1:n
    for j = 1:m
        q = [1, 8, 17, K(i)+10, K(i)*a(j)];
        p = roots(q);
        if max(real(p)) > 0
            x(i) = K(i);
            y(i) = a(j-1);
            break;
        end
    end
end

plot(x, y);
grid on;
xlabel('K');
ylabel('a');
end

function rampResponses(aKarray)
t = 0:0.1:16;
u = t;  % Unit Ramp input

figure;
hold on;
for i = 1:length(aKarray)
    a = aKarray(i,1);
    K = aKarray(i,2);
    sys =getSystem(a, K);
    y = lsim(sys, u, t);
    plot(t, y, 'DisplayName', sprintf('a=%.2f, K=%.2f', a, K));
end

plot(t, u, '--', 'DisplayName', 'Unit Ramp Reference');
hold off;
xlabel('Time (s)');
ylabel('y(t) ramp response');
legend;
grid on;
end

function sys = getSystem(a, K)
sysgc = tf([1 a], [1 1]);
sysg = tf(K, [1 7 10 0]);
sys = feedback(sysgc*sysg, 1);
end