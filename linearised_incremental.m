K_s = 1.8;
J_m = 7.5e-6; 
J_t = 0.001;

A = [0 0 1 0 0;
     0 0 0 1 0;
     -K_s/J_m K_s/J_m 0 0 0;
     K_s/J_t -K_s/J_t 0 0 0;
     0 0 -K_m/L_a 0 -R/L_a];

B = [0; 0; K_m/(R * J_m); 0; 1/L_a];

C = [0 1 0 0 0];
D = 0;

A
B
C
D

[b, a] = ss2tf(A, B, C, D);

sys = tf(b, a);

bode(sys)