figure(3); clf reset;
phase_lead_zero = w_instersetion
phase_lead_pole = alpha * phase_lead_zero
sys_gc = k * tf([1 phase_lead_zero], [1 phase_lead_pole])
sys_compansated = sys_gc * sys_g
margin(sys_compansated)

figure(4); clf reset;
k = 1770; % found phase margin 58.9
sys_gc = k * tf([1 phase_lead_zero], [1 phase_lead_pole])
sys_compansated = sys_gc * sys_g
margin(sys_compansated)

figure(5); clf reset;

sys_final = feedback(sys_compansated, 1)
stepinfo(sys_final)
stepplot(sys_final, t)