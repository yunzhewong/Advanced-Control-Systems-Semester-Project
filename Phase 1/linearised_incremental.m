x2_bar = pi / 6;
T_bar = m * g * l / 2;
V_bar = ((T_bar / K_m) + I_noload) * R;

X1_BAR = deg2rad(31.78);
K_s = T_bar / (X1_BAR - x2_bar);

A = [0 0 1 0 0;
     0 0 0 1 0;
     -K_s/J_m K_s/J_m 0 0 0;
     K_s/J_t -(K_s/J_t)-((sqrt(3)/2)*m*g*l/J_t) 0 0 0;
     0 0 -K_m/L_a 0 -R/L_a];

B = [0; 0; K_m/(R * J_m); 0; 1/L_a];

C = [0 1 0 0 0];
D = 0;

[sys_b, sys_a] = ss2tf(A, B, C, D);
sys = tf(sys_b, sys_a);
