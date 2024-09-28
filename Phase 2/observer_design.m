% Continuous Time - Full State Observer Design
eig(A);

closest_pole = -100;

observer_poles = [closest_pole closest_pole-1 closest_pole-2 closest_pole-3];
J_observer_transpose = place(A', C_m', observer_poles);
J_observer = J_observer_transpose';

observer_matrix = A - J_observer*C_m;
eig(observer_matrix);

% Discrete Time - Reduced Order Observer
disc_a = sys_disc.A;
disc_b = sys_disc.B;

A_aa = A(1:2, 1:2);
A_ab = A(1:2, 3:4);
A_ba = A(3:4, 1:2);
A_bb = A(3:4, 3:4);

B_a = B(1:2, :);
B_b = B(3:4, :);

L_r = place(A_bb', A_ab', [closest_pole, closest_pole+1])';

A_aa_disc = disc_a(1:1, 1:1);
A_ab_disc = disc_a(1:1, 2:4);
A_ba_disc = disc_a(2:4, 1:1);
A_bb_disc = disc_a(2:4, 2:4);

B_a_disc = disc_b(1:1, :);
B_b_disc = disc_b(2:4, :);

disc_poles = exp([closest_pole, closest_pole-1, closest_pole-2] * min_sampling_time);
L_r_disc = place(A_bb_disc', A_ab_disc', disc_poles)';