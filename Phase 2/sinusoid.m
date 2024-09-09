T = 4;
w = 2 * pi / T;

A_s = [0 1; -w^2 0];

C_sin = [0 1 0 0;
         0 0 0 1];
err_dyna = [0 1 0 0; 0 0 0 0];
A_sin_aug = [A_s err_dyna;zeros(4,2) A]
B_sin_aug = [zeros(2, 1); B]

ctrb(A_sin_aug, B_sin_aug)

K_sin = place(A_sin_aug, B_sin_aug, [-3+2i -3-2i -25+400i -25-400i -60 -61])
K_sin_s = K_sin(1)
K_sin_x = K_sin(2:5)

eig(A_sin_aug - B_sin_aug*K_sin)