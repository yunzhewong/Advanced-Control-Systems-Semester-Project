A_aug = [1 C_l; zeros(4, 1) disc_sys.A];
B_aug = [0; disc_sys.B];
C_aug = [0 C_l]; 

nx = size(A_aug, 2);
nu = size(B_aug, 2);

gamma = 6;
C_q = [gamma C_l];
Q = C_q'*C_q;
R = 231;
[P, ~] = idare(A_aug, B_aug, Q, R);

ny = size(C_aug, 1);
C_mpc = [C_aug; sqrtm(Q); sqrtm(P)];
D_mpc = zeros(ny + nx + nx, nu);

Wy = blkdiag(zeros(ny), eye(nx), zeros(nx));
WyN = blkdiag(zeros(ny), zeros(nx), eye(nx));
Wu = sqrtm(R);
WDeltau = 0;

mpc_plant = ss(A_aug, B_aug, C_mpc, D_mpc, min_sampling_time);

W = struct();
W.ManipulatedVariables = diag(Wu).';
W.ManipulatedVariablesRate = diag(WDeltau).';
W.OutputVariables = diag(Wy).';

MV = struct();
MV.Min = -12 - V_bar;
MV.Max = 12 - V_bar;

%% SPECIFY THE OUTPUT VARIABLE CONSTRAINTS
OV = struct();
OV(1).Min = deg2rad(15) - x2_bar;
OV(1).Max = deg2rad(45) - x2_bar;
OV(1).MinECR = 0.5;
OV(1).MaxECR = 0.5;

prediction_horizon = 100;
control_horizon = prediction_horizon;
mpc_obj = mpc(mpc_plant, min_sampling_time, prediction_horizon, control_horizon, W, MV, OV);

%% SET THE TERMINAL WEIGHT
% > For the output variables
terminal_setting_for_OV = struct();
terminal_setting_for_OV.Weight = diag(WyN).';
% > For the manipulated variables
terminal_setting_for_MV = struct();
terminal_setting_for_MV.Weight = W.ManipulatedVariables;
terminal_setting_for_MV.Min = MV.Min;
terminal_setting_for_MV.Max = MV.Max;
% > Call the function to set
setterminal(mpc_obj, terminal_setting_for_OV, terminal_setting_for_MV);

%% SET THE STATE ESTIMATOR
setEstimator(mpc_obj,'custom');

%% SET THE OUTPUT DISTURBANCE TO ZERO
setoutdist(mpc_obj,'model',ss(zeros(ny + nx + nx,1)));

%% CREATE THE MPC INITIAL STATE VARIABLE
% > Create the variable for the MPC block
mpc_initial_state = mpcstate(mpc_obj);
mpc_initial_state.Plant = [0, theta_m_init - x1_bar, theta_l_init - x2_bar, thetadot_m_init, thetadot_l_init];

display(mpc_obj)