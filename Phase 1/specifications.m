STEADY_STATE_ERROR_DEGREES = 2;
OVERSHOOT_DEGREES = 5;
SETTLING_TIME_SECONDS = 2; % 2% settling time

LOW_REFERENCE_DEGREES = 15;
HIGH_REFERENCE_DEGREES = 45;

rise_difference = (HIGH_REFERENCE_DEGREES - LOW_REFERENCE_DEGREES);
overshoot_percent = OVERSHOOT_DEGREES / rise_difference;
steady_state_error_percent = STEADY_STATE_ERROR_DEGREES / rise_difference;


syms zeta
zeta = solve(log(overshoot_percent) == -pi * zeta / (sqrt(1 - zeta^2)));

fprintf("Required Damping (zeta): %.3f\n", zeta);

syms wn
wn = solve(-SETTLING_TIME_SECONDS * zeta * wn == log((2 / 100) * sqrt(1 - zeta^2)));
fprintf("Required Natural Frequency (w_n): %.3f\n", wn);

wc = wn * sqrt(sqrt(1 + 4 * zeta^4) - 2 * zeta^2);
fprintf("Required Crossover Frequency (w_c): %.3f\n", wc);

Mf_rad = atan((2 * zeta) / (sqrt(sqrt(1 + 4 * zeta^4) - 2 * zeta^2)));
Mf_deg = rad2deg(Mf_rad);
fprintf("Required Phase Margin (Mf) (degrees): %.3f\n", Mf_deg);

sigma = zeta * wn;
wd = wn * sqrt(1-zeta^2);

fprintf("Minimum Sigma: %.3f\n", sigma)
fprintf("Corresponding Damped Frequency (w_d): %.3f\n", wd)