figure
plot(nosoft_t, nosoft_x, "DisplayName", "Without Soft Constraints - Raw")
hold on
plot(out.qpstatus.Time, out.qpstatus.Data, "DisplayName", "With Soft Constraints - Raw")

ROLLING_COUNT = 20;
rollingwithout = movmean(nosoft_x, ROLLING_COUNT);
rollingwith = movmean(out.qpstatus.Data, ROLLING_COUNT);
plot(nosoft_t, rollingwithout, "LineWidth", 2, "DisplayName", "Without Soft Constraints - Rolling Average")
plot(out.qpstatus.Time, rollingwith ,"LineWidth", 2, "DisplayName", "With Soft Constraints - Rolling Average")

legend("Location", "northwest")
xlabel("Time")
ylabel("Quadratic Program Iterations")
title("Comparing Soft Constraint Effect on Quadratic Program")
xlim([0 21])