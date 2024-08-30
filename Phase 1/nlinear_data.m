SAMPLING_FREQUENCY = 50;
sampling_time = 1 / SAMPLING_FREQUENCY;
discrete_controller = c2d(controller, sampling_time, 'zoh');
[c_disc_b, c_disc_a] = tfdata(discrete_controller, 'v');

%% 
createSystemSpecFigure()
plot(out.nonlinearpos.Time, out.nonlinearpos.Data, "r-", "DisplayName", "Non-Linear Plant Response")
title("Non-Linear Plant Response")

figure
plot(out.voltage.Time, out.voltage.Data, "r-", "DisplayName", "Motor Voltage Command")
hold on
title("Motor Voltage Command")
xlabel("Time (s)")
ylabel("Voltage (V)")
xlim([0 21])
ylim([-4 14])

V_noload = I_noload * R;

fill([0 21 21 0], [V_noload V_noload 12 12], "b", "FaceAlpha", 0.1)
legend("Voltage Command", "Linear Operating Region", "Location", "southeast")