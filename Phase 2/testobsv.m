syms Ks Jm R Jt Km La



A_sym = [0 0 1 0 0;
         0 0 0 1 0;
         -Ks/Jm Ks/Jm 0 0 Km/Jm;
         Ks/Jt -(Ks/Jt)-((sqrt(3)/2)*m*g*l/Jt) 0 0 0;
         0 0 -Km/La 0 -R/La];
B_sym = [0; 0; 0; 0; 1/La];
C = [1 0 0 0 0];

ctrb = [B_sym A_sym*B_sym A_sym^2*B_sym A_sym^3*B_sym A_sym^4*B_sym]

original_controllability = rank(ctrb);

fprintf("Original Controllability: %d\n", original_controllability)

obsv = [C; C*A_sym; C*A_sym^2; C*A_sym^3; C*A_sym^4]
rref(obsv)
original_observability = rank(obsv);
fprintf("Original Observability: %d\n", original_controllability)


A_sym_red = [0 0 1 0;
         0 0 0 1;
         -Ks/Jm Ks/Jm -Km^2/(Jm*R) 0;
         Ks/Jt -(Ks/Jt)-((sqrt(3)/2)*m*g*l/J_t) 0 0];
B_sym_red = [0; 0; Km/(Jm * R); 0];
C_red = [0 0 0 1];


ctrb_red = [B_sym_red A_sym_red*B_sym_red A_sym_red^2*B_sym_red A_sym_red^3*B_sym_red];
reduced_controllability = rank(ctrb_red);
fprintf("Reduced Controllability: %d\n", reduced_controllability)

obsv_red = [C_red; C_red*A_sym_red; C_red*A_sym_red^2; C_red*A_sym_red^3];
reduced_observability = rank(obsv_red);
fprintf("Reduced Observability: %d\n", reduced_controllability)