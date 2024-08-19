close all
s = tf('s');

figure
margin(sys)

% with lead and integrator
% test = zpk([], [0 -0.1 -100], 10^(103 / 20));

test = zpk([-1.2 -10], [-120 0], 1);
figure
margin(sys * test)

figure
rlocus(sys * test)

closed_loop = feedback(sys * test, 1)
zpkcl = zpk(closed_loop)

figure
step(feedback(sys * test, 1))
% 
% % with another lead
% double_lead_integrator = zpk([-20 -20], [0 -200 -1000], 1);
% figure
% rlocus(sys * double_lead_integrator)
% 
% % with gain correctly picked

controller = zpk([-5 -10.5], [0 -200 -100], 1e4*10^(0/20));

figure
rlocus(sys * controller)

figure
margin(sys * controller)

figure
step(feedback(sys * controller, 1));
% 
% [c_b, c_a] = tfdata(test,'v');
% 
% SAMPLING_FREQUENCY = 50;
% sampling_time = 1 / SAMPLING_FREQUENCY;
% discrete_controller = c2d(test, sampling_time, 'zoh');
% [c_disc_b, c_disc_a] = tfdata(discrete_controller,'v');
