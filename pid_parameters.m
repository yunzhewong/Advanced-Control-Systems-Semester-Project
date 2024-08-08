w_c = 10;
Mf_target = deg2rad(60);

tz2 = 10 / w_c;
tp1 = 1 / (10 * w_c);

phi_c = Mf_target + 90 - angle((10j + 1) / (0.1j + 1)) - angle(evalfr(sys, w_c)) - 180;
tz1 = tan(phi_c) / w_c;

K = (w_c * abs(0.1j + 1)) / (abs(10j + 1)*abs(tz1*w_c*1i + 1)*abs(evalfr(sys, w_c)));

C = K * (tz1 * s + 1) * (tz2 * s + 1) / ((tp1 * s + 1) * s)