
% time = out.InputSignal.Time;
% inputData = out.InputSignal.Data;
% visionOutput = out.VisionSensor.Data;
% 
% figure
% plot(time, inputData);
% hold on
% plot(time, visionOutput);

plant_extrema_times = [0.129 0.376 0.626 0.877];
sensor_extrema_times = [0.188 0.430 0.690 0.932];

diffs = sensor_extrema_times - plant_extrema_times;
time_delay = mean(diffs);

fprintf("The Time Delay is %.4fs\n",time_delay)