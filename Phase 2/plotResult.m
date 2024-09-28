%%
close all

%%
fig = figure;
[~, low_index] = min(abs(out.link_angle.Time - 3));
[~, high_index] = min(abs(out.link_angle.Time - 6));
createSystemSpecFigure(fig, out.link_angle.Data(low_index), out.link_angle.Data(high_index));


%% High
xlim([2.75, 6.25])
ylim([32.5 52.5])
xline(5, "DisplayName", "2 Seconds After Change")
title("Step Up")
legend("Location", "southeast")

%% Low
xlim([5.75, 9.25])
ylim([5 30])
xline(8, "DisplayName", "2 Seconds After Change")
legend("Location", "northeast")
title("Step Down")

%% C1: Continuous Full State Feedback (With / Without Emulation)
% without emulation
plot(out.link_angle, "DisplayName", "Without Emulation", "Color", "magenta")

% with emulation
plot(out.link_angle_2, "DisplayName", "With Emulation", "Color", "green")


%% C2: Discrete Full State Feedback
% discrete full state feedback
plot(out.link_angle, "DisplayName", "True Angle", "Color", "magenta")
% title("Discrete Full State Feedback")

%% D1: Continuous Time Full State Observer (With / Without Emulation)
% without emulation
plot(out.link_angle, "DisplayName", "Without Emulation", "Color", "magenta")

% with emulation
plot(out.link_angle_2, "DisplayName", "With Emulation", "Color", "green")
% title("Full State Observer-Based Continuous Full State Feedback Without and With Emulation")

%% D2: Discrete Time Reduced Order Observer
% discrete reduced order observer
plot(out.link_angle, "DisplayName", "True Angle", "Color", "magenta")
% title("Reduced-Order Observer-Based Discrete Full State Feedback")
%% E: Sinusoid Reference Tracking
fig = figure;
plotSinusoidFigure(fig)
% using sinusoid-rejection loop
plot(out.link_angle, "DisplayName", "Sinusoid Rejection", "Color", "blue")

% using discrete integral control
plot(out.link_angle_2, "DisplayName", "Integral Control", "Color", "green")
title("Sinusoid Reference Tracking Using Sinusoid Rejection Control and Integral Control")



