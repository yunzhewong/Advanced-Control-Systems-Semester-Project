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


w_c = 10;
Mf_target = deg2rad(60);

tz2 = 100 / w_c;
tp1 = 1 / (100 * w_c);

phi_c = Mf_target + 90 - angle((10j + 1) / (0.1j + 1)) - angle(evalfr(sys, w_c)) - 180;
tz1 = tan(phi_c) / w_c;

K = (w_c * abs(0.1j + 1)) / (abs(10j + 1)*abs(tz1*w_c*1i + 1)*abs(evalfr(sys, w_c)));

C = 0.5 * K * (tz1 * s + 1) * (tz2 * s + 1) / ((tp1 * s + 1) * s)


figure
bode((1/3)*s + 1)
figure
bode(C)

figure
bode(sys)

figure
margin(C * sys)

figure
rlocus(C * sys)

closed_loop = feedback(C * sys, 1);
figure
step(closed_loop)

zpksys = zpk(closed_loop)


