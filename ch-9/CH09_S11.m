
sys_pd = tf([1 1], 1)

Tao_1 = 10^-3
sys_motor_coil = tf(5, [Tao_1, 1])

Tao_2 = 1/20
sys_arm = tf(0.05, conv([1 0], [Tao_2, 1]))

zet = 0.3
w_n = 18.85e03
sys_flexure_and_head = tf(1, [w_n^-2 2*zet/w_n 1])

sys_open = minreal(sys_pd * sys_motor_coil * sys_arm * sys_flexure_and_head)
K = 400
sys = minreal(feedback(K*sys_open, 1))
figure(1); margin(sys)
