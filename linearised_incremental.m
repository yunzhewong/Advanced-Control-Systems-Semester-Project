close all

J_m = 7.5e-6; 
J_t = 0.001;
x2_bar = pi / 6;
T_bar = m * g * l / 2;
V_bar = ((T_bar / K_m) + I_noload) * R;

x1_bar = deg2rad(31.78);
K_s = T_bar / (x1_bar - x2_bar);
K_s

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

w_c = 20;

controller = zpk([-10+460i -10-460i -3-9i -3+9i -4], [-5 0 -10000 -10000 -10000], 1e7);
[c_b, c_a] = tfdata(controller,'v');

figure
bode(controller)

figure
bode(sys)

figure
margin(controller * sys)

figure
rlocus(controller * sys)


figure
step(feedback(controller * sys, 1))

