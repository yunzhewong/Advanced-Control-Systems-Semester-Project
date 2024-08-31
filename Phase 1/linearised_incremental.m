format short g

K_s = 1.58;
b = (0.019 - 0.013) / 2;

A = [0 0 1 0 0;
     0 0 0 1 0;
     -K_s/J_m K_s/J_m 0 0 0;
     K_s/J_t -(K_s/J_t)-((sqrt(3)/2)*m*g*l/J_t) 0 0 0;
     0 0 -K_m/L_a 0 -R/L_a];
B = [0; 0; K_m/(R * J_m); 0; 1/L_a];
C = [0 1 0 0 0];
D = 0;



[b, a] = ss2tf(A, B, C, D);
sys = tf(b, a)
figure
step(sys)