% Convert G(s) = (2s^2+8s+6)/(s^3+8s^2+16s+6)
% to a state-space representation
num=[2 8 6]; den=[1 8 16 6]; sys_tf=tf(num,den);
sys_ss=ss(sys_tf);

A=[0 -2; 1 -3]; dt=0.2; Phi=expm(A*dt)



A=[0 -2;1 -3]; B=[2;0]; C=[1 0]; D=[0];
sys=ss(A,B,C,D);
x0=[1 1];
t=[0:0.01:1];
u=0*t;
[y,T,x]=lsim(sys,u,t,x0);
subplot(121), plot(T,x(:,1))
xlabel('Time (s)'), ylabel('x_1')
subplot(122), plot(T,x(:,2))
xlabel('Time (s)'), ylabel('x_2')