T = 4;
w = 2 * pi / T;

A_s = [0 w; -w 0];

C_sin = [0 1 0 0;
         0 0 0 0];
err_dyna = [0 0 0 1; 0 0 0 0];

A_sin_aug = [A_s zeros(2, 1) C_sin; zeros(1,2) 0 C; zeros(4,3) A]
B_sin_aug = [zeros(3, 1); B]

K_sin = place(A_sin_aug, B_sin_aug, [-2.5+8i -2.5-8i -25 -26 -50 -60 -70])
K_sin_s = K_sin(1:2)
K_sin_int = K_sin(3)
K_sin_x = K_sin(4:7)

% A_sin_aug = [A_s C_sin; zeros(4,2) A]
% B_sin_aug = [zeros(2, 1); B]
% 
% K_sin = place(A_sin_aug, B_sin_aug, [-1 -2 -25 -26 -50 -60])
% K_sin_s = K_sin(1:2)
% % K_sin_int = K_sin(3)
% K_sin_x = K_sin(3:6)



% eig(A_sin_aug - B_sin_aug*K_sin)