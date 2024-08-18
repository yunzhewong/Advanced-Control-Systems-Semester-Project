close all
s = tf('s');

figure
margin(sys)

% with lead and integrator
test = zpk([], [0], 1);
figure
rlocus(sys * test)

figure
step(feedback(sys * base_lead_integrator, 1))

% with another lead
double_lead_integrator = zpk([-20 -20], [0 -200 -1000], 1);
figure
rlocus(sys * double_lead_integrator)

% with gain correctly picked
controller = zpk([-5 -10], [0 -200 -100], 1e4);
figure
step(feedback(sys * controller, 1));

[c_b, c_a] = tfdata(controller,'v');

SAMPLING_FREQUENCY = 50;
sampling_time = 1 / SAMPLING_FREQUENCY;
discrete_controller = c2d(controller, sampling_time, 'zoh');
[c_disc_b, c_disc_a] = tfdata(discrete_controller,'v');
