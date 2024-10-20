%% CLEAR THE WORKSPACE
clear
clc

%% PLANT PARAMETERS
m  = 1;     % mass in kg
l  = 1;     % length in m
Ks = 10;    % Sping coefficient in Nm/rad
Jm = 0.01;  % Motor inertia
Jl = 1;     % Link inertia
g  = 9.81;  % Gravity

%% LTI SYSTEM MATRICES
A = [...
0,       0,              1,  0;...
0,       0,              0,  1;...
-Ks/Jm,   Ks/Jm,          0,  0;...
Ks/Jl,  -(Ks+m*g*l)/Jl,  0,  0;...
];
B = [0; 0; 1/Jm; 0];

%% STATE AND INPUT SIZES
nx = size(A,2);
nu = size(B,2);

%% SPECIFY THE Q AND R WEIGHTING MATRICES
% > for penalising each state as a diagonal matrix
Q = diag( [2, 2, 2, 2] );
% > for penalising the input
R = 3;

%% SPECIFY THE SAMPLE TIME OF THE CONTROLLER
sample_time = 1/50;

%% COMPUTE THE RICATTI SOLUTION
C_for_lqr = eye(nx);
D_for_lqr = zeros(nx,nu);
ss_continuous_for_lqr = ss(A,B,C_for_lqr,D_for_lqr);
ss_discrete_for_lqr = c2d(ss_continuous_for_lqr, sample_time, 'zoh' );
[P_lqr, K_lqr] = idare(ss_discrete_for_lqr.A,ss_discrete_for_lqr.B,Q,R);

%% SPECIFY THE TERMINAL COST WEIGHTING MATRIX
P = P_lqr;

%% SPECIFY THE C FOR DEFINING THE y_k PART TO BE USED IN THE CONSTRAINTS
C_for_constraints = [ 0 , 1 , 0 , 0 ];
ny = size(C_for_constraints,1);

%% CONSTRUCT THE WEIGHTING MATRICES FOR MATLAB MPC FORMULATION
% > for the state terms in the cost function
Wy = blkdiag( zeros(ny,ny) , eye(nx,nx) , zeros(nx) );
% > for the terminal state term in the cost function
WyN = blkdiag( zeros(ny,ny) , zeros(nx,nx) , eye(nx) );
% > for input terms in the cost function
Wu = chol(R);
% > for input change terms in the cost function
WDeltau = 0;


%% BUILD THE PLANT
% Specify the C and D
C_for_mpc = [ C_for_constraints ; chol(Q) ; chol(P) ];
D_for_mpc = zeros(ny+nx+nx,nu);
% Build the continuous-time plant
LTI_plant_continuous_time = ss(A,B,C_for_mpc,D_for_mpc);
% Convert to a discrete-time plant
LTI_plant_discrete_time = c2d(LTI_plant_continuous_time, sample_time, 'zoh' );

%% PUT THE WEIGHTINGS INTO A STRUCT
W = struct();
W.ManipulatedVariables     = diag(Wu).';
W.ManipulatedVariablesRate = diag(WDeltau).';
W.OutputVariables          = diag(Wy).';

%% SPECIFY THE MANIPULATED VARIABLE CONSTRAINTS
MV = struct();
MV.Min         = -4; %[Nm]
MV.Max         =  4; %[Nm]
MV.MinECR      = 0;
MV.MaxECR      = 0;
MV.RateMin     = -Inf;
MV.RateMax     = Inf;
MV.RateMinECR  = 0;
MV.RateMaxECR  = 0;
MV.Target      = 'nominal';
MV.Name        = 'T';
MV.Units       = 'Nm';
MV.ScaleFactor = 1;

%% SPECIFY THE OUTPUT VARIABLE CONSTRAINTS
OV = struct();
OV(1).Min         = deg2rad(-25);
OV(1).Max         = deg2rad( 25);
OV(1).MinECR      = 0.1;
OV(1).MaxECR      = 0.1;
OV(1).Name        = 'theta_l';
OV(1).Units       = 'radians';
OV(1).ScaleFactor = 1;

%% CREATE THE MPC OBJECT
prediction_horizon = 20;
control_horizon = prediction_horizon;
mpc_obj = mpc(LTI_plant_discrete_time, sample_time, prediction_horizon, control_horizon, W, MV, OV);

%% SET THE TERMINAL WEIGHT
% > For the output variables
terminal_setting_for_OV = struct();
terminal_setting_for_OV.Weight = diag(WyN).';
% > For the manipulated variables
terminal_setting_for_MV = struct();
terminal_setting_for_MV.Weight = W.ManipulatedVariables;
% > Call the function to set
setterminal(mpc_obj, terminal_setting_for_OV, terminal_setting_for_MV);

%% SET THE STATE ESTIMATOR
setEstimator(mpc_obj,'custom');

%% SET THE OUTPUT DISTURBANCE TO ZERO
setoutdist(mpc_obj,'model',ss(zeros(ny+nx+nx,1)));

%% CREATE THE MPC INITIAL STATE VARIABLE
% > Specify the initial condition for each state
theta_l_init     = deg2rad(20);
theta_m_init     = deg2rad(20);
theta_l_dot_init = deg2rad(0);
theta_m_dot_init = deg2rad(0);
% > Create the variable for the MPC block
mpc_initial_state = mpcstate(mpc_obj);
mpc_initial_state.Plant = [theta_l_init, theta_m_init, theta_l_dot_init, theta_m_dot_init];

%% DISPLAY THE MPC OBJECT
display(mpc_obj)

% %% COMPUTE FEED-FORWARD CONVERSION VIA PLANT INVERSION
% % Specify the link angle as the reference
% C_for_theta_l = [0, 1, 0, 0];
% % Perform the inversion
% N_ff = inv( [A, B; C_for_theta_l, 0] );
% % Set any inversion artifact to zero
% N_ff( abs(N_ff)<1e-8 ) = 0;
% % Extract the state and input parts
% Nx_ff = N_ff(1:4,5);
% Nu_ff = N_ff(5,5);
