format short g

K_s = 1.58;

A = [0 0 1 0 0;
     0 0 0 1 0;
     -K_s/J_m K_s/J_m 0 0 K_m/J_m;
     K_s/J_t -(K_s/J_t)-((sqrt(3)/2)*m*g*l/J_t) 0 0 0;
     0 0 -K_m/L_a 0 -R/L_a];
B = [0; 0; 0; 0; 1/L_a];
C = [0 1 0 0 0];
D = 0;

eig(A)

Co = ctrb(A, B);
cond(Co);
rank(Co, 1e-15)

Ob = obsv(A, C);
cond(Ob);
rank(obsv(A, [0 1 0 0 0]), 1e-15)
rank(obsv(A, [1 0 0 0 0]), 1e-15)
rank(obsv(A, [1 0 0 0 0]), 1e-15)
rank(obsv(A, [0 0 1 0 0]), 1e-15)
rank(obsv(A, [0 0 0 1 0]), 1e-15)
rank(obsv(A, [0 1 0 1 0]), 1e-15)
rank(obsv(A, [1 0 1 0 0]), 1e-15)
rank(obsv(A, [1 0 0 1 0]), 1e-15)


