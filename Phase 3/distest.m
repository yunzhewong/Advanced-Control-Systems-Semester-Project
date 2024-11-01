figure
plot(out.dist.Time, out.dist.Data, "DisplayName", "Disturbance Signal")
hold on
plot(out.estdist.Time, out.estdist.Data, "DisplayName", "Estimated Disturbance")
xlabel("Time (s)")
ylabel("Disturbance Voltage (V)")
title("Estimated Disturbance vs True Disturbance")
legend("Location", "southeast")