A_aug = [0 C_l; zeros(4, 1) A];
B_aug = [0; B];
C_aug = [6 C_l];

rho = 1/10;

Q = C_aug' * C_aug;
R = rho;

[K, S, P] = lqr(A_aug, B_aug, Q, R)
K_int = K(1);
K_x = K(2:end);

[b, a] = ss2tf(A_aug, B_aug, C_aug, 0);
inversed = a(:,:);

for i = 1:numel(inversed)
    reverse_index = numel(inversed) - i;
    if mod(reverse_index, 2) == 1
        inversed(i) = inversed(i) * -1;
    end
end
numGG = b(end)^2;
denGG = conv(a, inversed);

sysGG = tf(numGG, denGG);
rlocus(sysGG)