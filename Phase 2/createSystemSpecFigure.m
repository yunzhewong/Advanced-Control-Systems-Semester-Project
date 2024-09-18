function createSystemSpecFigure()
    f = figure;
    f.Position = [100 100 1000 500];

    hold on

    STEADY_STATE_ERROR_DEGREES = 2;
    OVERSHOOT_DEGREES = 5;
    
    LOW_REFERENCE_DEGREES = 15;
    HIGH_REFERENCE_DEGREES = 45;
    
    rise_difference = (HIGH_REFERENCE_DEGREES - LOW_REFERENCE_DEGREES);

    MAX_OVERSHOOT = HIGH_REFERENCE_DEGREES + OVERSHOOT_DEGREES;
    MIN_OVERSHOOT = LOW_REFERENCE_DEGREES - OVERSHOOT_DEGREES;
    max_overshoot_y = [MAX_OVERSHOOT MAX_OVERSHOOT MAX_OVERSHOOT+15 MAX_OVERSHOOT+15];
    min_overshoot_y = [MIN_OVERSHOOT MIN_OVERSHOOT MIN_OVERSHOOT-15 MIN_OVERSHOOT-15];
    overshoot_x = [0 21 21 0];
    
    two_percent_degrees = 0.02 * rise_difference;
    
    fill(overshoot_x, max_overshoot_y, "k", "FaceAlpha", 0.5)
    yline(HIGH_REFERENCE_DEGREES + two_percent_degrees, ":", "LineWidth", 1, "Color", "k")
    yline(HIGH_REFERENCE_DEGREES - two_percent_degrees, ":", "LineWidth", 1, "Color", "k")
    yline(HIGH_REFERENCE_DEGREES + STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    yline(HIGH_REFERENCE_DEGREES - STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    
    fill(overshoot_x, min_overshoot_y, "k", "FaceAlpha", 0.5)
    yline(LOW_REFERENCE_DEGREES + two_percent_degrees, ":", "LineWidth", 1, "Color", "k")
    yline(LOW_REFERENCE_DEGREES - two_percent_degrees, ":", "LineWidth", 1, "Color", "k")
    yline(LOW_REFERENCE_DEGREES + STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    yline(LOW_REFERENCE_DEGREES - STEADY_STATE_ERROR_DEGREES, "-", "LineWidth", 1, "Color", "b")
    
    legend("Overshoot Zone", "2% Settling Time Bounds", "", "Steady State Bounds", "Location", "southeast")
    ylim([0 55])
    xlim([0 21])
    
    xlabel("Time (s)")
    ylabel("Angle (degrees)")
end