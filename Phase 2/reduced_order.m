format short g

K_s = 1.58;

A = [0 0 1 0;
     0 0 0 1;
     -K_s/J_m K_s/J_m -K_m^2/(J_m*R) 0;
     K_s/J_t -(K_s/J_t)-((sqrt(3)/2)*m*g*l/J_t) 0 0];
B = [0; 0; K_m/(J_m * R); 0];
C = [1 0 0 0;
     0 1 0 0];




eig(A)

x1_bar = deg2rad(31.78);
x2_bar = deg2rad(30);

[b, a] = ss2tf(A, B, C, zeros(2, 1));

Co = ctrb(A, B)
cond(Co)
rank(Co)

Ob = obsv(A, C)
cond(Ob)
rank(Ob)

