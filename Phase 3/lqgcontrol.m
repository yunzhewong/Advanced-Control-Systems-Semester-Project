kappa = 1e7;

W = kappa * [0 0 0 0; 
             0 0 0 0; 
             0 0 1 0; 
             0 0 0 1];
V = 1;

[K, S, P] = lqr(A', C_m', W, V)
J_observer = K';