close all

A_aug = [0 C_l; zeros(4, 1) A];
B_aug = [0; B];
C_aug = [3 C_l];

aug = 30

Q = [aug^2 0 aug 0 0;
     0 0 0 0 0;
     aug 0 2 0 0;
     0 0 0 0 0;
     0 0 0 0 0.2];
R = 1/231;

[K, S, P] = lqr(A_aug, B_aug, Q, R)
K_int = K(1);
K_x = K(2:end);