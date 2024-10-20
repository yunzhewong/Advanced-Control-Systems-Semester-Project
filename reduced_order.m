format short g

K_s = 1.58;

A = [0 0 1 0;
     0 0 0 1;
     -K_s/J_m K_s/J_m -K_m^2/(J_m*R_a) 0;
     K_s/J_t -(K_s/J_t)-((sqrt(3)/2)*m*g*l/J_t) 0 0];
B = [0; 0; K_m/(J_m * R_a); 0];
C_m = [1 0 0 0];
C_l = [0 1 0 0];

% eig(A)

x1_bar = deg2rad(31.78);
x2_bar = deg2rad(30);
V_bar = ((m*g*l/2)/K_m + I_noload)*R_a;

disc_sys = c2d(ss(A,B,C_l, []), min_sampling_time, 'zoh');

% [b, a] = ss2tf(A, B, C_m, 0);
% 
% Co = ctrb(A, B);
% fprintf("cond(Co): %d\n", cond(Co))
% fprintf("rank(Co): %d\n", rank(Co))
% 
% Ob = obsv(A, C_m);
% fprintf("cond(Ob): %d\n", cond(Ob))
% fprintf("rank(Ob): %d\n", rank(Ob))

