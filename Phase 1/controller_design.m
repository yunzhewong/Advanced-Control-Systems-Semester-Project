close all
s = tf('s');

figure
margin(sys)

controller = zpk([-0.2 -3+5i -3-5i], [-0.1 -0.1 -20], 10^(37/20) * 0.20);

figure
rlocus(sys * controller)

figure
margin(sys * controller)

figure
step(feedback(sys * controller, 1));

[c_b, c_a] = tfdata(controller,'v');

SAMPLING_FREQUENCY = 2;
sampling_time = 1 / SAMPLING_FREQUENCY;
discrete_controller = c2d(controller, sampling_time, 'foh');
[c_disc_b, c_disc_a] = tfdata(discrete_controller,'v');

figure
bode(controller, discrete_controller)

