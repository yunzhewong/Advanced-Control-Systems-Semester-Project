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
     K_s/J_t -K_s/J_t-(sqrt(3)/2)*m*g*l/J_t 0 0 0;
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

s = tf('s')

w_c = 3;
tz = 10 / w_c
tp = 1 / (10 * w_c)
C = (tz*s + 1)^2/(tp*s + 1)^2
zpksys = zpk(sys)

figure
bode(sys)

figure
bode(C)

figure
bode(sys * C)

figure
rlocus(sys * C)