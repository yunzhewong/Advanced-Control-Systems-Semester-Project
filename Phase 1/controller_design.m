close all
s = tf('s');

figure
bode(sys)
title("Plant Bode Diagram")

base_controller = zpk([], [-0.1 -0.1], 1)
figure
bode(sys * base_controller)


controller = zpk([-0.2 -3+5i -3-5i], [-0.1 -0.1 -20], 10^(37/20) * 0.20);

figure
rlocus(sys * controller)

figure
margin(sys * controller)

figure
bode(sys * controller)
title("Open Loop Bode Plot")

figure
step(feedback(sys * controller, 1));

[c_b, c_a] = tfdata(controller,'v');

sampling_time = 1 / 50;
discrete_controller = c2d(controller, sampling_time, 'zoh');
[c_disc_b, c_disc_a] = tfdata(discrete_controller, 'v');