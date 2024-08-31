p = [-7 -3+5i, -3-5i, -25+460i, -25-460i];

A_int = [0 C; zeros(4, 1) A];
B_int = [0; B];
K = place(A_int, B_int, p);
K_int = K(1,1);
K_x = K(1, 2:5);

[b, a] = ss2tf(A, B, C, D);
sys = tf(b, a);
N_x = 1 / dcgain(sys);

A_int_disc = [1 C; zeros(4, 1) A];