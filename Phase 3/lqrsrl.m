close all

A_aug = [0 C_l; zeros(4, 1) A];
B_aug = [0; B];
C_aug = [3 C_l];

% Plotting of Symmetric Root Locus
[b, a] = ss2tf(A_aug, B_aug, C_aug, 0);
numGG = conv(b, inverse(b));
denGG = conv(a, inverse(a));

sysGG = tf(numGG, denGG);
figure
rlocus(sysGG)

% K Definition
rho = 1/231;

Q = C_aug' * C_aug;
R = rho;

[K, S, P] = lqr(A_aug, B_aug, Q, R);
K_int_srl = K(1);
K_x_srl = K(2:end);

function out = inverse(in)
    out = in(:, :);
    for i = 1:numel(in)
        reverse_index = numel(in) - i;
        if mod(reverse_index, 2) == 1
            out(i) = out(i) * -1;
        end
    end
end