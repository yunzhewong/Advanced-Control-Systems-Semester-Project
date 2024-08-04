K_s = 1.6;
J_m = 1; % Unknown
J_t = 0.001;

A = [0 0 1 0 0;
     0 0 0 1 0;
     -K_s/J_m K_s/J_m 0 0 0;
     K_s/J_t -K_s/J_t-sqrt(3) * m*g*l/(2 * J_t) 0 0 0;
     0 0 -K_m/L_a 0 -R/L_a];

B = [0; 0; 1/J_m; 0; 1/L_a];

C = [0 1 0 0 0];
D = 0;

[b, a] = ss2tf(A, B, C, D);

sys = tf(b, a);

bode(sys)