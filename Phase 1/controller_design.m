close all
s = tf('s');

figure
margin(sys)

% with lead and integrator
% test = zpk([], [0 -0.1 -100], 10^(103 / 20));

% test = zpk([-1.2 -10], [-120 0], 1);
% figure
% margin(sys * test)
% 
% figure
% rlocus(sys * test)
% 
% closed_loop = feedback(sys * test, 1)
% zpkcl = zpk(closed_loop)
% 
% figure
% step(feedback(sys * test, 1))
% 
% % with another lead
% double_lead_integrator = zpk([-20 -20], [0 -200 -1000], 1);
% figure
% rlocus(sys * double_lead_integrator)
% 
% % with gain correctly picked

controller = zpk([-0.2 -3+6i -3-6i], [-0.1 -0.1 -20], 10^(37/20) * 0.20)
% controller = zpk([-5 -10.5], [0 -200 -100], 1e4);
% controller = zpk([-10+460i -10-460i -3-9i -3+9i -2], [-5 0 -10000 -10000 -10000], 1e7)

figure
rlocus(sys * controller)

figure
margin(sys * controller)

figure
step(feedback(sys * controller, 1));

[c_b, c_a] = tfdata(controller,'v');

SAMPLING_FREQUENCY = 5;
sampling_time = 1 / SAMPLING_FREQUENCY;
discrete_controller = c2d(controller, sampling_time, 'zoh');
[c_disc_b, c_disc_a] = tfdata(discrete_controller,'v');
