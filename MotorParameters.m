%% Motor 1
% R = 2.6;
% K_m = 0.5369;
% I_noload = 0.1;
% L_a = 0.18e-3;

%% Motor 2
R = 2;
K_m = 27e-3;
I_noload = 0.26;
L_a = 1.3e-3;


low_torque = 0.0254;
high_torque = 0.0694;

low_voltage = low_torque * R / K_m;
high_voltage = high_torque * R / K_m;

low_current = low_voltage / R;
high_current = high_voltage / R;

disp([low_voltage, high_voltage])
disp([low_current, high_current])