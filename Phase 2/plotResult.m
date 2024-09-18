close all

fig = figure;
[~, low_index] = min(abs(out.link_angle.Time - 3));
[~, high_index] = min(abs(out.link_angle.Time - 6));
createSystemSpecFigure(fig, out.link_angle.Data(low_index), out.link_angle.Data(high_index));
plot(out.link_angle)