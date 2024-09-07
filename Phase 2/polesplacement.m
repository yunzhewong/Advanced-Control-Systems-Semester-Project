% FROM A1
ideal_zeta = 0.4954;
ideal_sigma = 2.026;
ideal_wn = ideal_sigma / ideal_zeta;

picked_zeta = 0.75;
picked_wn = ideal_wn * 1;

fprintf("Zeta: %.4f\n", picked_zeta);
fprintf("Natural Frequency: %.4f\n", picked_wn);

ideal_sys = tf(1, [1 2*picked_wn*picked_zeta picked_wn^2]);
ideal_poles = pole(ideal_sys)

% Pole Definition
p = [-25 ideal_poles' -30+460i, -30-460i];

A_cont_aug = [0 C; zeros(4, 1) A];
B_cont_aug = [0; B];
K_cont = place(A_cont_aug, B_cont_aug, p);
K_cont_int = K_cont(1,1);
K_cont_x = K_cont(1, 2:5);

% Discretised version
sys = ss(A, B, C, D);
sys_disc = c2d(sys, min_sampling_time, "zoh");

A_disc_aug = [1 sys_disc.C; zeros(4,1) sys_disc.A];
B_disc_aug = [0; sys_disc.B];
disc_poles = exp(p .* min_sampling_time);
K_disc = place(A_disc_aug, B_disc_aug, disc_poles);
K_disc_int = K_disc(1,1);
K_disc_x = K_disc(1, 2:5);

