%% ============================================================
%  CURRENT-ONLY BATTERY IDENTIFICATION
%  Subsystems:
%     1) current^2 -> Tb
%     2) current   -> SoC
%
%  Assumptions for this dataset:
%     heatpwr = 0
%     omega   = 0 or constant
%     T_env   = constant
%     current is the excitation input
%  ============================================================

%  Extract data from Simulink
%  ------------------------------------------------------------

Tb       = current_pulse.Data(:,1);
SoC      = current_pulse.Data(:,2);
heatpwr  = current_pulse.Data(:,3);
omega    = current_pulse.Data(:,4);
current  = current_pulse.Data(:,5);

Ts=0.1 ; % sampling time of the system 

N = length(current);
t = (0:N-1)' * Ts;

%%

fprintf('\n===== Data summary =====\n');
fprintf('Number of samples = %d\n', N);
fprintf('Sample time Ts    = %.4f s\n', Ts);
fprintf('Total time        = %.2f s\n', t(end));

%% ------------------------------------------------------------
%  Quick signal check
%  ------------------------------------------------------------

figure;
subplot(5,1,1)
plot(t, Tb, 'LineWidth', 1.1)
grid on
ylabel('Tb')
title('Raw Logged Signals')

subplot(5,1,2)
plot(t, SoC, 'LineWidth', 1.1)
grid on
ylabel('SoC')

subplot(5,1,3)
plot(t, heatpwr, 'LineWidth', 1.1)
grid on
ylabel('heatpwr')

subplot(5,1,4)
plot(t, omega, 'LineWidth', 1.1)
grid on
ylabel('\omega')

subplot(5,1,5)
plot(t, current, 'LineWidth', 1.1)
grid on
ylabel('current')
xlabel('Time [s]')

%% ============================================================
%  PART 1: THERMAL MODEL current^2 -> Tb
%  ============================================================

%  ------------------------------------------------------------
%  Prepare current^2 -> Tb data
%  ------------------------------------------------------------

u_Tb_I2 = current.^2;       % thermal input
y_Tb_delta = Tb - Tb(1);    % temperature rise/change

data_Tb_I2 = iddata(y_Tb_delta, u_Tb_I2, Ts);
data_Tb_I2.InputName = {'current_squared'};
data_Tb_I2.OutputName = {'Tb_delta'};
data_Tb_I2.TimeUnit = 'seconds';

figure;
plot(data_Tb_I2)
grid on
title('Identification Data: current^2 to Tb')

%% ------------------------------------------------------------
%  Estimate thermal models
%  ------------------------------------------------------------

M_Tb_I2_P1D = procest(data_Tb_I2, 'P1D');
M_Tb_I2_P2D = procest(data_Tb_I2, 'P2D');
M_Tb_I2_P3D = procest(data_Tb_I2, 'P3D');

G_Tb_I2_2  = tfest(data_Tb_I2, 2, 0);
G_Tb_I2_3  = tfest(data_Tb_I2, 3, 0);
G_Tb_I2_3z = tfest(data_Tb_I2, 3, 1);

figure;
compare(data_Tb_I2, ...
    M_Tb_I2_P1D, M_Tb_I2_P2D, M_Tb_I2_P3D, ...
    G_Tb_I2_2, G_Tb_I2_3, G_Tb_I2_3z)
grid on
title('Thermal Model Comparison: current^2 to Tb')

%% ------------------------------------------------------------
%  Select thermal model
%  ------------------------------------------------------------
% Based on your previous result, P2D was acceptable.
% Change this line if another model performs better.

G_Tb_I2 = M_Tb_I2_P2D;

fprintf('\n===== Selected thermal model: current^2 -> Tb =====\n');
disp(G_Tb_I2)
fprintf('Stable = %d\n', isstable(G_Tb_I2));
fprintf('DC gain = %.6f\n', dcgain(G_Tb_I2));

%% ------------------------------------------------------------
%  Thermal residual and error metrics
%  ------------------------------------------------------------

figure;
resid(data_Tb_I2, G_Tb_I2)
title('Residual Analysis: current^2 to Tb')

[yhat_Tb_I2, fit_Tb_I2, x0_Tb_I2] = compare(data_Tb_I2, G_Tb_I2);

y_Tb_meas = data_Tb_I2.OutputData;
y_Tb_pred = yhat_Tb_I2.OutputData;

e_Tb_I2 = y_Tb_meas - y_Tb_pred;

RMSE_Tb_I2 = sqrt(mean(e_Tb_I2.^2));
MAE_Tb_I2  = mean(abs(e_Tb_I2));
MAX_Tb_I2  = max(abs(e_Tb_I2));

fprintf('\n===== Thermal model error metrics =====\n');
fprintf('Fit    = %.4f %%\n', fit_Tb_I2);
fprintf('RMSE   = %.6f\n', RMSE_Tb_I2);
fprintf('MAE    = %.6f\n', MAE_Tb_I2);
fprintf('MAXERR = %.6f\n', MAX_Tb_I2);

figure;
plot(t, y_Tb_meas, 'LineWidth', 1.2); hold on
plot(t, y_Tb_pred, '--', 'LineWidth', 1.2)
grid on
legend('Measured Tb delta','Predicted Tb delta')
xlabel('Time [s]')
ylabel('Tb delta')
title('Thermal Model: Measured vs Predicted')

figure;
plot(t, e_Tb_I2, 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('Tb residual')
title('Thermal Residual Time Series: current^2 to Tb')

figure;
plot(t, abs(e_Tb_I2), 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('|Tb residual|')
title('Thermal Residual Magnitude: current^2 to Tb')

%% Step response for thermal model

figure;
step(G_Tb_I2)
grid on
title('Step Response: current^2 to Tb')

%% ============================================================
%  PART 2: SoC MODEL current -> SoC
%  ============================================================

% ------------------------------------------------------------
%  Prepare current -> SoC data
%  ------------------------------------------------------------

u_SoC_current = current;          % signed current
y_SoC_delta   = SoC - SoC(1);     % SoC change

data_SoC_current = iddata(y_SoC_delta, u_SoC_current, Ts);
data_SoC_current.InputName = {'current'};
data_SoC_current.OutputName = {'SoC_delta'};
data_SoC_current.TimeUnit = 'seconds';

figure;
plot(data_SoC_current)
grid on
title('Identification Data: current to SoC')

%% ------------------------------------------------------------
%  Estimate black-box SoC state-space models
%  ------------------------------------------------------------

opt_SoC = ssestOptions;
opt_SoC.Focus = 'simulation';
opt_SoC.Display = 'on';

SS_SoC_current_1 = ssest(data_SoC_current, 1, opt_SoC);
SS_SoC_current_2 = ssest(data_SoC_current, 2, opt_SoC);
SS_SoC_current_3 = ssest(data_SoC_current, 3, opt_SoC);

figure;
compare(data_SoC_current, ...
    SS_SoC_current_1, SS_SoC_current_2, SS_SoC_current_3)
grid on
title('Black-box SoC Model Comparison: current to SoC')

%% ------------------------------------------------------------
%  Select SoC model
%  ------------------------------------------------------------
% Based on your previous result, order 1 was enough.

G_SoC_current = SS_SoC_current_1;

fprintf('\n===== Selected SoC model: current -> SoC =====\n');
disp(G_SoC_current)
fprintf('Stable = %d\n', isstable(G_SoC_current));

%% ------------------------------------------------------------
%  SoC residual and error metrics
%  ------------------------------------------------------------

figure;
resid(data_SoC_current, G_SoC_current)
title('Residual Analysis: current to SoC')

[yhat_SoC_current, fit_SoC_current, x0_SoC_current] = compare(data_SoC_current, G_SoC_current);

y_SoC_meas = data_SoC_current.OutputData;
y_SoC_pred = yhat_SoC_current.OutputData;

e_SoC_current = y_SoC_meas - y_SoC_pred;

RMSE_SoC_current = sqrt(mean(e_SoC_current.^2));
MAE_SoC_current  = mean(abs(e_SoC_current));
MAX_SoC_current  = max(abs(e_SoC_current));

fprintf('\n===== SoC model error metrics =====\n');
fprintf('Fit    = %.4f %%\n', fit_SoC_current);
fprintf('RMSE   = %.6f\n', RMSE_SoC_current);
fprintf('MAE    = %.6f\n', MAE_SoC_current);
fprintf('MAXERR = %.6f\n', MAX_SoC_current);

figure;
plot(t, y_SoC_meas, 'LineWidth', 1.2); hold on
plot(t, y_SoC_pred, '--', 'LineWidth', 1.2)
grid on
legend('Measured SoC delta','Predicted SoC delta')
xlabel('Time [s]')
ylabel('SoC delta')
title('SoC Model: Measured vs Predicted')

figure;
plot(t, e_SoC_current, 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('SoC residual')
title('SoC Residual Time Series: current to SoC')

figure;
plot(t, abs(e_SoC_current), 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('|SoC residual|')
title('SoC Residual Magnitude: current to SoC')

%% ------------------------------------------------------------
%  Build combined current-only model
%  ------------------------------------------------------------

G_Tb_I2_ss = ss(G_Tb_I2);
G_SoC_current_ss = ss(G_SoC_current);

G_Tb_I2_ss.InputName = {'current_squared'};
G_Tb_I2_ss.OutputName = {'Tb_delta'};

G_SoC_current_ss.InputName = {'current'};
G_SoC_current_ss.OutputName = {'SoC_delta'};

SS_current_total = append(G_Tb_I2_ss, G_SoC_current_ss);

SS_current_total.InputName = {'current_squared','current'};
SS_current_total.OutputName = {'Tb_delta','SoC_delta'};

fprintf('\n===== Combined current-only model =====\n');
disp(SS_current_total)
fprintf('Stable = %d\n', isstable(SS_current_total));

%% ------------------------------------------------------------
%  Validate combined current-only model
%  ------------------------------------------------------------

% Combined current-only model validation

u_current_total = [current.^2, current];
y_current_total = [Tb - Tb(1), SoC - SoC(1)];

data_current_total = iddata(y_current_total, u_current_total, Ts);
data_current_total.InputName = {'current_squared','current'};
data_current_total.OutputName = {'Tb_delta','SoC_delta'};
data_current_total.TimeUnit = 'seconds';

figure;
compare(data_current_total, SS_current_total)
grid on
title('Combined Current-only Model Validation')

%% Simulate combined model using lsim, not sim

t_current_total = (0:length(current)-1)' * Ts;

SS_current_total_lti = ss(SS_current_total);

Y_current_total_hat = lsim(SS_current_total_lti, u_current_total, t_current_total);

Tb_delta_hat_current_total  = Y_current_total_hat(:,1);
SoC_delta_hat_current_total = Y_current_total_hat(:,2);

Tb_hat_current_total  = Tb(1)  + Tb_delta_hat_current_total;
SoC_hat_current_total = SoC(1) + SoC_delta_hat_current_total;

figure;
subplot(2,1,1)
plot(t_current_total, Tb, 'LineWidth', 1.2); hold on
plot(t_current_total, Tb_hat_current_total, '--', 'LineWidth', 1.2)
grid on
legend('Measured Tb','Predicted Tb')
xlabel('Time [s]')
ylabel('Tb')
title('Combined Current-only Model: Tb')

subplot(2,1,2)
plot(t_current_total, SoC, 'LineWidth', 1.2); hold on
plot(t_current_total, SoC_hat_current_total, '--', 'LineWidth', 1.2)
grid on
legend('Measured SoC','Predicted SoC')
xlabel('Time [s]')
ylabel('SoC')
title('Combined Current-only Model: SoC')

%% ------------------------------------------------------------
%  Convert combined current-only model to transfer-function matrix
%  ------------------------------------------------------------

TF_current_total = tf(SS_current_total);

fprintf('\n===== Combined current-only transfer function matrix =====\n')
disp(TF_current_total)

%% ------------------------------------------------------------
%  Save current-only identification results
%  ------------------------------------------------------------

save('current_only_Tb_SoC_blackbox_models.mat', ...
    ... % raw logged data
    'Tb', ...
    'SoC', ...
    'heatpwr', ...
    'omega', ...
    'current', ...
    't', ...
    'Ts', ...
    ...
    ... % individual iddata objects
    'data_Tb_I2', ...
    'data_SoC_current', ...
    'data_current_total', ...
    ...
    ... % selected subsystem models
    'G_Tb_I2', ...
    'G_SoC_current', ...
    ...
    ... % candidate thermal models
    'M_Tb_I2_P1D', ...
    'M_Tb_I2_P2D', ...
    'M_Tb_I2_P3D', ...
    'G_Tb_I2_2', ...
    'G_Tb_I2_3', ...
    'G_Tb_I2_3z', ...
    ...
    ... % candidate SoC models
    'SS_SoC_current_1', ...
    'SS_SoC_current_2', ...
    'SS_SoC_current_3', ...
    ...
    ... % combined model
    'SS_current_total', ...
    'TF_current_total', ...
    ...
    ... % predictions
    'Tb_hat_current_total', ...
    'SoC_hat_current_total', ...
    'Tb_delta_hat_current_total', ...
    'SoC_delta_hat_current_total', ...
    ...
    ... % thermal errors
    'e_Tb_I2', ...
    'RMSE_Tb_I2', ...
    'MAE_Tb_I2', ...
    'MAX_Tb_I2', ...
    'fit_Tb_I2', ...
    ...
    ... % SoC errors
    'e_SoC_current', ...
    'RMSE_SoC_current', ...
    'MAE_SoC_current', ...
    'MAX_SoC_current', ...
    'fit_SoC_current');

fprintf('\nSaved current-only models to current_only_Tb_SoC_blackbox_models.mat\n');

