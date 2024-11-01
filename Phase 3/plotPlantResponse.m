function plotPlantResponse(mpc_5_t, mpc_5_x, mpc_20_t, mpc_20_x, out)
    f = figure;
    f.Position = [100 100 800 400];

    [~, low_index] = min(abs(out.link_angle.Time - 3));
    [~, high_index] = min(abs(out.link_angle.Time - 6));

    lowss = out.link_angle.Data(low_index);
    highss = out.link_angle.Data(high_index);

    t = tiledlayout(1, 2, "TileSpacing", "compact","Padding","compact");
    title(t, "MPC Different Horizon Performance")

    nexttile
    plotSubPlot(lowss, highss)
    plot(mpc_5_t, mpc_5_x, "Color", "magenta", "DisplayName", "5 Iterations")
    plot(mpc_20_t, mpc_20_x, "Color", "green", "DisplayName", "20 Iterations")
    plot(out.link_angle.Time, out.link_angle.Data, "Color", "#D95319", "DisplayName", "100 Iterations")
    legend("Location", "southeast")
    title("Step Up")
    xlim([2.5 6.5])
    ylim([30 55])

    nexttile
    plotSubPlot(lowss, highss)
    plot(mpc_5_t, mpc_5_x, "Color", "magenta", "DisplayName", "5 Iterations")
    plot(mpc_20_t, mpc_20_x, "Color", "green", "DisplayName", "20 Iterations")
    plot(out.link_angle.Time, out.link_angle.Data, "Color", "#D95319", "DisplayName", "100 Iterations")
    legend("Location", "northeast")
    title("Step Down")
    xlim([5.5, 9.5])
    ylim([5 30])
end

function plotSubPlot(lowss, highss)
    STEADY_STATE_ERROR_DEGREES = 2;
    OVERSHOOT_DEGREES = 5;
    LOW_REFERENCE_DEGREES = 15;
    HIGH_REFERENCE_DEGREES = 45;
    MAX_OVERSHOOT = HIGH_REFERENCE_DEGREES + OVERSHOOT_DEGREES;
    MIN_OVERSHOOT = LOW_REFERENCE_DEGREES - OVERSHOOT_DEGREES;
    ZERO_POINT_FIVE_BOUND = 0.5;

    max_overshoot_y = [MAX_OVERSHOOT MAX_OVERSHOOT MAX_OVERSHOOT+15 MAX_OVERSHOOT+15];
    min_overshoot_y = [MIN_OVERSHOOT MIN_OVERSHOOT MIN_OVERSHOOT-15 MIN_OVERSHOOT-15];
    overshoot_x = [0 21 21 0];

    hold on
    reference_x = 0:0.01:21;
    reference_y = zeros(1, numel(reference_x));

    for i = 1:numel(reference_x)
        time = reference_x(i);
        is_low_ref = mod(ceil(time / 3) - 1, 2) == 0;
        if is_low_ref
            reference_y(i) = LOW_REFERENCE_DEGREES;
        else
            reference_y(i) = HIGH_REFERENCE_DEGREES;
        end
    end

    plot(reference_x, reference_y, 'Color', 'r');
        
    fill(overshoot_x, max_overshoot_y, "k", "FaceAlpha", 0.5)
    yline(highss + ZERO_POINT_FIVE_BOUND, ":", "LineWidth", 1, "Color", "k")
    yline(highss - ZERO_POINT_FIVE_BOUND, ":", "LineWidth", 1, "Color", "k")
    yline(HIGH_REFERENCE_DEGREES + STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    yline(HIGH_REFERENCE_DEGREES - STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    
    fill(overshoot_x, min_overshoot_y, "k", "FaceAlpha", 0.5)
    yline(lowss + ZERO_POINT_FIVE_BOUND, ":", "LineWidth", 1, "Color", "k")
    yline(lowss - ZERO_POINT_FIVE_BOUND, ":", "LineWidth", 1, "Color", "k")
    yline(LOW_REFERENCE_DEGREES + STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    yline(LOW_REFERENCE_DEGREES - STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")

    legend("Reference", "Overshoot Zone", "Settling Time Bounds", "", "Steady State Bounds", "Location", "southeast")
    ylim([5 55])
    xlim([0 21])

    xlabel("Time (s)")
    ylabel("Angle (degrees)")
end