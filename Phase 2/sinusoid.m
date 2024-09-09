T = 4;
w = 2 * pi / T;

A_s = [0 1; -w^2 0];

C_sin = [0 1 0 0;
         0 0 0 1];
A_sin_aug = [zeros(2,3) A_s*C_sin;zeros(1,3) C; zeros(4,3) A]
B_sin_aug = [zeros(3, 1); B]

ctrb(A_sin_aug, B_sin_aug)

K_sin = place(A_sin_aug, B_sin_aug, [-3+2i -3-2i -25+400i -25-400i -60 -70 -80])
K_sin_s = K_sin(1)
K_sin_x = K_sin(2:5)

eig(A_sin_aug - B_sin_aug*K_sin)