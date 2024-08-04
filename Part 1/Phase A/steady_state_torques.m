
T_p1 = steady_state_torque(15);
disp(T_p1)

T_p2 = steady_state_torque(45);
disp(T_p2)

max_velocity = deg2rad(35) / 0.5;
disp(max_velocity)

function T = steady_state_torque(angle_degrees)
    m = 0.1;
    g = 9.81;
    l = 0.1;
    T = m * g * l * sind(angle_degrees);
end
