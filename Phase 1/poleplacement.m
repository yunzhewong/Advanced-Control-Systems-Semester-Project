syms s

dominant_zeta = 0.55;
dominant_sigma = 2.5;
dominant_wn = dominant_sigma / dominant_zeta;

fast_sigma = 20;
fast_zeta = 0.1;
fast_wn = fast_sigma / fast_zeta;

fast_real_pole = 20

dominant_pair = (s + dominant_sigma - dominant_wn * 1i) * (s + dominant_sigma + dominant_wn * 1i)
fast_pair = (s + fast_sigma - fast_wn * 1i) * (s + fast_sigma + fast_wn * 1i)
fast_pole = (s + fast_real_pole)




closed_loop = dominant_pair * fast_pair * fast_pole
original_poles = (s^2 + 84.32) * (s^2 + 2.121e5);
K = 2.8419e6;
b = simplify(closed_loop - original_poles * s) / K
res = factor(b, s, "FactorMode", "complex")
