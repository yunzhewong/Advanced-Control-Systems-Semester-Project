kappa = 1e3;

W = kappa * [0 0 0 0; 
             0 0 0 0; 
             0 0 1 0; 
             0 0 0 1];
V = 1;

[K, ~, poles] = dlqr(disc_sys.A', C_m', W, V)
mpc_kalman_gain = K';