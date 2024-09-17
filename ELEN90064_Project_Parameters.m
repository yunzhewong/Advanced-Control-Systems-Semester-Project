clear

%% DEFINE THE PLANT INITIAL CONDITIONS

% Initial link angle [radians]
theta_l_init = deg2rad(30);
% Initial link velocity [radians/second]
thetadot_l_init = deg2rad(0);
% Initial motor angle [radians]
theta_m_init = deg2rad(30);
% Initial motor velocity [radians/second]
thetadot_m_init = deg2rad(0);
% Initial motor current [Amps]
Ia_init = 0;

% Initial conditions stacked as a 5x1 vector
init = [theta_m_init; theta_l_init; thetadot_m_init; thetadot_l_init; Ia_init];

%% DEFINE THE SENSOR PARAMETERS

% FOR VISION:
% > The frames per second [fps]
% > Allowed values: 25, 50, 100
vision_fps = 50;

% FOR ABSOLUTE ENCODER
% > Number of counts per revolution
% absolute_encoder_counts_per_revolution = 128;
absolute_encoder_counts_per_revolution = 4096;

% FOR POTENTIOMETER
% > Percentage linearity [percent]
potentiometer_linearity_percent = 0.2;

% FOR TACHOMETER
% > Number of counts per revolution
tachometer_counts_per_revolution = 2048;
% > Frequency of the velocity estimates
% > Allowed values: 10, 25, 50, 100
tachometer_output_frequency = 50;

% FOR GYROSCOPE
% > Variance of the noise that drives the drift process [rad/s^2]
gyro_sigma_drift = deg2rad(5);


%% Link Parameters
m = 0.1;
l = 0.1;
g = 9.81;
J_t = 0.001;

%% Wave Parameters
wave_amplitude = deg2rad(15);
wave_offset = deg2rad(30);
wave_period = 6;

%% Sampling Parameters
max_sampling_frequency = 50;
min_sampling_time = 1/50;