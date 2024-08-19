close all
s = tf('s');

figure
margin(sys)

% with lead and integrator
% test = zpk([], [0 -0.1 -100], 10^(103 / 20));
test = zpk([-3+4i -3-4i -10-460i -10+460i], [0 -0.1 -0.1 -0.1], 10^((-110 + 240) / 20));
figure
margin(sys * test)

figure
rlocus(sys * test)

figure
step(feedback(sys * test, 1))
% 
% % with another lead
% double_lead_integrator = zpk([-20 -20], [0 -200 -1000], 1);
% figure
% rlocus(sys * double_lead_integrator)
% 
% % with gain correctly picked
controller = zpk([-5 -10], [0 -200 -100], 1e4);
figure
step(feedback(sys * controller, 1));

[c_b, c_a] = tfdata(test,'v');

SAMPLING_FREQUENCY = 50;
sampling_time = 1 / SAMPLING_FREQUENCY;
discrete_controller = c2d(test, sampling_time, 'zoh');
[c_disc_b, c_disc_a] = tfdata(discrete_controller,'v');
