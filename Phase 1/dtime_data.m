sampling_frequencies = [100 50 30 20 10];
% 
createSystemSpecFigure()

for i = 1:numel(sampling_frequencies)
    sampling_time = 1 / sampling_frequencies(i);
    discrete_controller = c2d(controller, sampling_time, 'zoh')
    [c_disc_b, c_disc_a] = tfdata(discrete_controller, 'v');

    model = 'closedloop';
    load_system(model)
    simout = sim(model);

    times = simout.dtime.Time(:, 1)';
    data = simout.dtime.Data(:, 1)';

    plot(times, data, 'DisplayName', "f = " + compose("%d", sampling_frequencies(i)) + "Hz")
end

title("Plant Responses with Varying Sample Time FOH Discretised Controllers")