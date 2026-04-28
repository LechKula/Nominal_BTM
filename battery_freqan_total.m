%% extract dat from simulink 

Tb       = current_pulse.Data(:,1);
SoC      = current_pulse.Data(:,2);
heatpwr  = current_pulse.Data(:,3);
omega    = current_pulse.Data(:,4);
current  = current_pulse.Data(:,5);



%%

u_Tb = current.^2;    % entering the current as a quad in the sysytem 
y_Tb = Tb - Tb(1);    % filtering the delta 


data_Tb = iddata(y_Tb, u_Tb, Ts);

M_Tb_P1D = procest(data_Tb, 'P1D');
M_Tb_P2D = procest(data_Tb, 'P2D');

figure;
compare(data_Tb, M_Tb_P1D, M_Tb_P2D)
grid on
title('Thermal Model: I^2 to Tb')

%% process selection / residual 


G_Tb = M_Tb_P2D;

figure;
resid(data_Tb, G_Tb)
title('Residual Analysis: I^2 to Tb, P2D')

figure;
step(G_Tb)
grid on
title('Step Response: I^2 to Tb, P2D')


fprintf('Stable = %d\n', isstable(G_Tb));
fprintf('DC gain = %.6f\n', dcgain(G_Tb));
disp(G_Tb)

%% thrid order tests 

M_Tb_P2D = procest(data_Tb, 'P2D');
M_Tb_P3D = procest(data_Tb, 'P3D');

G_Tb_3  = tfest(data_Tb, 3, 0);
G_Tb_3z = tfest(data_Tb, 3, 1);
%%
figure;
compare(data_Tb, M_Tb_P2D, M_Tb_P3D, G_Tb_3, G_Tb_3z)
grid on
title('I^2 to Tb: Higher Order Thermal Models')

figure;
resid(data_Tb, G_Tb_3)
title('Residuals: I^2 to Tb, P3D')

%% residual checks for correlation 

G_Tb = M_Tb_P2D;

[yhat, fit, x0] = compare(data_Tb, G_Tb);

y_meas = data_Tb.OutputData;
y_pred = yhat.OutputData;
t_id = data_Tb.SamplingInstants;

e = y_meas - y_pred;

figure;
plot(t_id, e, 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('Residual Tb error')
title('Residual Time Series: measured Tb - model Tb')

%% checks passed for the coupling and the drifts locked and logged 

G_Tb_I2 = M_Tb_P2D;

% save model 

save('thermal_I2_to_Tb_P2D.mat', ...
     'G_Tb_I2', 'M_Tb_P2D', 'Ts');
% Model: I² → Tb
% Heating power = 0
% Fan speed = 0
% T_env = constant
% Current pulse test
% Output = Tb or Tb - Tb_initial
% Accepted small residual drift

%% current to SOC 

u_SoC_current = current;          % signed current, not current^2
y_SoC_delta   = SoC - SoC(1);     % SoC change from initial value

data_SoC_current = iddata(y_SoC_delta, u_SoC_current, Ts);

figure;
plot(data_SoC_current)
grid on
title('Identification Data: current to SoC change')

%% Estimate black-box state-space models

SS_SoC_1 = ssest(data_SoC_current, 1);
SS_SoC_2 = ssest(data_SoC_current, 2);
SS_SoC_3 = ssest(data_SoC_current, 3);

figure;
compare(data_SoC_current, SS_SoC_1, SS_SoC_2, SS_SoC_3)
grid on
title('Black-box SoC Model: current to SoC')

%%

G_SoC_current = SS_SoC_1;


figure;
resid(data_SoC_current, G_SoC_current)
title('Residuals: selected current to SoC black-box model')

figure;
compare(data_SoC_current, G_SoC_current)
grid on
title('Selected SoC Model: current to SoC')

fprintf('\n===== Selected SoC black-box model =====\n')
disp(G_SoC_current)

fprintf('Stable = %d\n', isstable(G_SoC_current))

%% save data 

SS_SoC_current = SS_SoC_1;

save('soc_current_blackbox_order1.mat', ...
     'SS_SoC_current', 'data_SoC_current', 'Ts')

%% Two-input thermal model: [current^2, omega] -> Tb

u_Tb_I2_omega = [current.^2, omega];
y_Tb_delta_omega = Tb - Tb(1);

data_Tb_I2_omega = iddata(y_Tb_delta_omega, u_Tb_I2_omega, Ts);

figure;
plot(data_Tb_I2_omega)
grid on
title('Data: [I^2, omega] to Tb')

%%

opt_ss_Tb = ssestOptions;
opt_ss_Tb.Focus = 'simulation';
opt_ss_Tb.Display = 'on';

SS_Tb_I2_omega_2 = ssest(data_Tb_I2_omega, 2, opt_ss_Tb);
SS_Tb_I2_omega_3 = ssest(data_Tb_I2_omega, 3, opt_ss_Tb);
SS_Tb_I2_omega_4 = ssest(data_Tb_I2_omega, 4, opt_ss_Tb);

figure;
compare(data_Tb_I2_omega, ...
    SS_Tb_I2_omega_2, SS_Tb_I2_omega_3, SS_Tb_I2_omega_4)
grid on
title('MISO Thermal Model: [I^2, omega] to Tb')

%%

G_Tb_I2_omega = SS_Tb_I2_omega_2;

figure;
resid(data_Tb_I2_omega, G_Tb_I2_omega)
title('Residuals: selected [I^2, omega] to Tb model')

figure;
compare(data_Tb_I2_omega, G_Tb_I2_omega)
grid on
title('Selected MISO Thermal Model: [I^2, omega] to Tb')

fprintf('\n===== Selected MISO thermal model =====\n')
disp(G_Tb_I2_omega)

fprintf('Stable = %d\n', isstable(G_Tb_I2_omega))

%% Residual time-series and magnitude plot for selected [I^2, omega] -> Tb model

G_Tb_I2_omega = SS_Tb_I2_omega_2;   % selected model

% Model output
[yhat_Tb_I2_omega, fit_Tb_I2_omega, x0_Tb_I2_omega] = compare(data_Tb_I2_omega, G_Tb_I2_omega);

% Residual
y_meas_Tb_I2_omega = data_Tb_I2_omega.OutputData;
y_pred_Tb_I2_omega = yhat_Tb_I2_omega.OutputData;

e_Tb_I2_omega = y_meas_Tb_I2_omega - y_pred_Tb_I2_omega;

% Time vector
t_Tb_I2_omega = (0:length(e_Tb_I2_omega)-1)' * Ts;
% or, if available:
% t_Tb_I2_omega = data_Tb_I2_omega.SamplingInstants;

% Signed residual
figure;
plot(t_Tb_I2_omega, e_Tb_I2_omega, 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('Residual')
title('Residual Time Series: [I^2, \omega] to Tb')

% Residual magnitude
figure;
plot(t_Tb_I2_omega, abs(e_Tb_I2_omega), 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('|Residual|')
title('Residual Magnitude Time Series: [I^2, \omega] to Tb')

% Useful metrics
RMSE_Tb_I2_omega = sqrt(mean(e_Tb_I2_omega.^2));
MAXERR_Tb_I2_omega = max(abs(e_Tb_I2_omega));
MAE_Tb_I2_omega = mean(abs(e_Tb_I2_omega));

fprintf('\n===== Residual metrics: [I^2, omega] -> Tb =====\n');
fprintf('RMSE   = %.6f\n', RMSE_Tb_I2_omega);
fprintf('MAE    = %.6f\n', MAE_Tb_I2_omega);
fprintf('MAXERR = %.6f\n', MAXERR_Tb_I2_omega);

%%

G_Tb_I2_omega = SS_Tb_I2_omega_2;

% Accepted model:
% inputs  = [current^2, omega]
% output  = Tb
% order   = 2 state-space
% fit     ≈ 99.73%
% residual magnitude ≈ 2e-3
% small structured drift accepted
% operating condition: current around 7 A, heatpwr = 0, constant environment

%% save the data 

SS_Tb_I2_omega = SS_Tb_I2_omega_2;

save('thermal_I2_omega_to_Tb_order2.mat', ...
     'SS_Tb_I2_omega', ...
     'data_Tb_I2_omega', ...
     'Ts', ...
     'RMSE_Tb_I2_omega', ...
     'MAE_Tb_I2_omega', ...
     'MAXERR_Tb_I2_omega')
%% ============================================================
%  Build total black-box battery model
%  Inputs  = [current^2, omega, current]
%  Outputs = [Tb_delta, SoC_delta]
%  ============================================================

% Accepted subsystem models
SS_Tb_I2_omega = SS_Tb_I2_omega_2;   % [current^2, omega] -> Tb_delta
SS_SoC_current = SS_SoC_1;           % current -> SoC_delta

% Convert to state-space explicitly
SS_Tb_I2_omega = ss(SS_Tb_I2_omega);
SS_SoC_current = ss(SS_SoC_current);

% Assign input/output names
SS_Tb_I2_omega.InputName  = {'current_squared','omega'};
SS_Tb_I2_omega.OutputName = {'Tb_delta'};

SS_SoC_current.InputName  = {'current'};
SS_SoC_current.OutputName = {'SoC_delta'};

% Append creates block diagonal system:
% inputs  = [current_squared, omega, current]
% outputs = [Tb_delta, SoC_delta]
SS_battery_total = append(SS_Tb_I2_omega, SS_SoC_current);

SS_battery_total.InputName  = {'current_squared','omega','current'};
SS_battery_total.OutputName = {'Tb_delta','SoC_delta'};

fprintf('\n===== Total identified battery model =====\n')
disp(SS_battery_total)

fprintf('Stable = %d\n', isstable(SS_battery_total))

%% Total model validation data

u_total = [current.^2, omega, current];

y_total = [Tb - Tb(1), SoC - SoC(1)];

data_battery_total = iddata(y_total, u_total, Ts);

data_battery_total.InputName  = {'current_squared','omega','current'};
data_battery_total.OutputName = {'Tb_delta','SoC_delta'};

%%
figure;
compare(data_battery_total, SS_battery_total)
grid on
title('Total Identified Battery Model Validation')