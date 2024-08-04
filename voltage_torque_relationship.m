close all

model = 'voltage_torque_mapping';
open_system(model)

voltages = 0:0.1:12;
block = model + "/Voltage";
set_param(block,"Value","val");

%%

for i = 1:numel(voltages)
    simIn(i) = Simulink.SimulationInput(model);
    simIn(i) = setVariable(simIn(i),"val",voltages(i));
end

out = sim(simIn, "UseFastRestart","on");


%%

for i = 1:numel(voltages)
    steady_state(i) = out(i).yout{1}.Values.Data(end);
end

expected = zeros(1, numel(voltages));

V_noload = I_noload * R;
for i = 1:numel(voltages)
    if (voltages(i) > V_noload)
        expected(i) = K_m * ((voltages(i) / R) - I_noload);
    end
end

figure
plot(voltages, steady_state, 'ro')
hold on
plot(voltages, expected, 'b-')
title("Motor 2 Voltage vs Steady State Torque at Zero Speed")
xlabel("Voltage (V)")
ylabel("Steady State Torque (Nm)")
legend("Simulated Results", "Expected Results from V=IR", "Location", 'southeast')