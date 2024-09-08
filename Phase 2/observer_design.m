C_o = [1 0 0 0;
       0 1 0 0];

% Continuous Time - Full State Observer Design
eig(A);

closest_pole = -100;

observer_poles = [closest_pole closest_pole-1 closest_pole-2 closest_pole-3];
J_observer_transpose = place(A', C_o', observer_poles);
J_observer = J_observer_transpose';

observer_matrix = A - J_observer*C_o;
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

L_r = place(A_bb', A_ab', [closest_pole, closest_pole+1])'