
C_o = [1 0 0 0;
       0 1 0 0];

eig(A)

closest_pole = -100;

observer_poles = [closest_pole closest_pole-1 closest_pole-2 closest_pole-3];
J_observer_transpose = place(A', C_o', observer_poles);
J_observer = J_observer_transpose';

observer_matrix = A - J_observer*C_o;
eig(observer_matrix)