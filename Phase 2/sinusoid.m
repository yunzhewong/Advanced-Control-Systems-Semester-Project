T = 4;
w = 2 * pi / T;

A_s = [0 w; -w 0];

sinusoid_ss = ss(A_s, [0; 0], [0 0], 0);
disc_sinusoid_ss = c2d(sinusoid_ss, min_sampling_time, "zoh");

C_sin = [C_l; zeros(1, 4)];

A_sin_aug = [disc_sinusoid_ss.A zeros(2, 1) C_sin; zeros(1, 2) 1 C_l;zeros(4,3) sys_disc.A];
B_sin_aug = [zeros(3, 1); sys_disc.B];

disc_sin_poles = exp([-3-3i -3+3i -22 -25+460i -25-460i -20 -21] * min_sampling_time);
K_sin = place(A_sin_aug, B_sin_aug, disc_sin_poles);
K_sin_s = K_sin(1:2);
K_sin_int = K_sin(3);
K_sin_x = K_sin(4:7);
eig(A_sin_aug)

eig(A_sin_aug - B_sin_aug*K_sin)