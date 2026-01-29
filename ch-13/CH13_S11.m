Ts = 1;
sysc = tf(1, [1 1 0])
sysc2d = c2d(sysc, Ts, 'zoh') % Discretization method 'zoh' (default) | 'foh' | 'impulse' | 'tustin' | 'matched' | 'least-squares' | 'damped'
sysd = tf([0.3679 0.2642], [1 -1.368 0.3679], Ts)
sysd2c = d2c(sysd, 'zoh') % Discrete-to-continuous time conversion method 'zoh' (default) | 'foh' | 'tustin' | 'matched