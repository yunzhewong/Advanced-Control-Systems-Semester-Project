C_d = [1 0];
w = 4 * pi;
A_sin = [0 w; -w 0];

A_dist_aug = [A B*C_d; zeros(2, 4) A_sin];
B_dist_aug = [B; zeros(2, 1)];
C_dist_aug = [C_m zeros(1, 2)];


kappa = 1e6;
W = kappa * [0 0 0 0 0 0; 
             0 0 0 0 0 0; 
             0 0 1 0 0 0; 
             0 0 0 1 0 0;
             0 0 0 0 1 0;
             0 0 0 0 0 1;];
V = 1;
[K, S, P] = lqr(A_dist_aug', C_dist_aug', W, V);

J_dist_est = K'