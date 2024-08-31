format short g

A = [0 0 1 0;
     0 0 0 1;
     -K_s/J_m K_s/J_m -K_m^2/(J_m*R) 0;
     K_s/J_t -(K_s/J_t)-((sqrt(3)/2)*m*g*l/J_t) 0 0];
B = [0; 0; K_m/(J_m * R); 0];
C = [0 1 0 0];
D = 0;

eig(A)

x1_bar = deg2rad(31.78);
x2_bar = deg2rad(30);

[b, a] = ss2tf(A, B, C, D);
sys = tf(b, a)
figure
step(sys)

Co = ctrb(A, B)
rank(Co, 1e-9)

Ob = obsv(A, C)
rank(Ob, 1e-9)

