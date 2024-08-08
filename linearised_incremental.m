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

zpksys = zpk(sys)

s = tf('s');

w_c = 100;
tz1 = 100 / (w_c)
tp = 1 / (100 * w_c);
C = ((s + 10) ^ 2) * (s - 5) 


figure
bode(s + 10)

figure
bode(s - 10)

figure
bode(sys)

figure
bode(C)

figure
bode(sys * C)

figure
step(feedback(sys * C, 1))

test = zpk(feedback(sys * C, 1))

figure
rlocus(sys * C)