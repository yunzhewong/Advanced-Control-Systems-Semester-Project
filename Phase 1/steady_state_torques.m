close all

steady_state_low_torque = steady_state_torque(15);
steady_state_high_torque = steady_state_torque(45);
max_velocity = deg2rad(35) / 0.5;

steady_state_low_voltage = steady_state_voltage(steady_state_low_torque, K_m, I_noload, R);
steady_state_high_voltage = steady_state_voltage(steady_state_high_torque, K_m, I_noload, R);

fprintf("Steady State Low Voltage: %.2f\n", steady_state_low_voltage)
fprintf("Steady State High Voltage: %.2f\n", steady_state_high_voltage)

voltages = linspace(0, V_max, 100);

torques = zeros(1, numel(voltages));
for i = 1:numel(voltages)
    effective_torque = K_m * ((voltages(i) / R ) - I_noload);
    if effective_torque > 0
        torques(i) = effective_torque;
    end
end

figure
plot(voltages, torques, 'k');
hold on
xline(steady_state_low_voltage, 'r')
xline(steady_state_high_voltage, 'b')
title("Motor 1 Voltage vs Torque Evaluation")
xlabel("Voltage (V)")
ylabel("Torque (Nm)")
legend("Voltage to Torque Relationship", "Steady State Low Voltage", "Steady State High Voltage", "Location", "southeast")

function T = steady_state_torque(angle_degrees)
    m = 0.1;
    g = 9.81;
    l = 0.1;
    T = m * g * l * sind(angle_degrees);
end

function V = steady_state_voltage(torque, K_m, I_noload, R)
    V = ((torque / K_m) + I_noload) * R;
end