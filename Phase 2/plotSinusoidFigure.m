function plotSinusoidFigure(fig)
    fig.Position = [100 100 1000 500];

    hold on

    AMPLITUDE = 25;
    OFFSET = 25;
    PERIOD = 4;

    STEADY_STATE_ERROR = 5;

    w = 2 * pi / PERIOD;
    x = 0:0.1:21;
    reference = AMPLITUDE * sin(w*x) + OFFSET;
    upper_bounds = reference + STEADY_STATE_ERROR;
    lower_bounds = reference - STEADY_STATE_ERROR;

    plot(x, reference, "r-")
    plot(x, lower_bounds, "k:", "LineWidth", 1);
    plot(x, upper_bounds, "k:", "LineWidth", 1);
   
    legend("Reference", "Steady State Bounds", "", "Location", "southeast")
    ylim([-5 55])
    xlim([0 21])
    
    xlabel("Time (s)")
    ylabel("Angle (degrees)")
end