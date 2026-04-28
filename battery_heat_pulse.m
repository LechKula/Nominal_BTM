%% ============================================================
%  HEAT POWER PULSE IDENTIFICATION
%
%  Subsystem:
%     [current^2, heatpwr] -> Tb_delta
%
%  Assumptions for this dataset:
%     current = constant, high, around 15 A
%     omega   = constant, around 01
%     heatpwr = excitation input
%     T_env   = constant
%
%  Notes:
%     omega is fixed in this test, so we do not identify omega -> Tb here.
%     current^2 is included to represent the baseline current heating.
%  ============================================================

%% Extract data from Simulink
% Change heat_pulse to your actual logged variable name

Tb       = heat_pulse.Data(:,1);
SoC      = heat_pulse.Data(:,2);
heatpwr  = heat_pulse.Data(:,3);
omega    = heat_pulse.Data(:,4);
current  = heat_pulse.Data(:,5);


Ts = 0.1;

N = length(current);
t = (0:N-1)' * Ts;

fprintf('\n===== Heat power pulse data summary =====\n');
fprintf('Number of samples = %d\n', N);
fprintf('Sample time Ts    = %.4f s\n', Ts);
fprintf('Total time        = %.2f s\n', t(end));

fprintf('Current mean = %.4f A\n', mean(current));
fprintf('Current std  = %.6f A\n', std(current));
fprintf('Omega mean   = %.4f\n', mean(omega));
fprintf('Omega std    = %.6f\n', std(omega));
fprintf('Heatpwr min  = %.4f\n', min(heatpwr));
fprintf('Heatpwr max  = %.4f\n', max(heatpwr));

%% ------------------------------------------------------------
%  Quick signal check
%  ------------------------------------------------------------

figure;
subplot(5,1,1)
plot(t, Tb, 'LineWidth', 1.1)
grid on
ylabel('Tb')
title('Raw Logged Signals: Heat Power Pulse Test')

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
%  PART 1: Thermal model [current^2, heatpwr] -> Tb
%  ============================================================

u_Tb_I2_heat = [current.^2, heatpwr];
y_Tb_delta_heat = Tb - Tb(1);

data_Tb_I2_heat = iddata(y_Tb_delta_heat, u_Tb_I2_heat, Ts);
data_Tb_I2_heat.InputName  = {'current_squared','heatpwr'};
data_Tb_I2_heat.OutputName = {'Tb_delta'};
data_Tb_I2_heat.TimeUnit   = 'seconds';

figure;
plot(data_Tb_I2_heat)
grid on
title('Identification Data: [current^2, heatpwr] to Tb')

%% ------------------------------------------------------------
%  Estimate black-box heat power models
%  ------------------------------------------------------------

opt_heat = ssestOptions;
opt_heat.Focus = 'simulation';
opt_heat.Display = 'on';

SS_Tb_I2_heat_2 = ssest(data_Tb_I2_heat, 2, opt_heat);
SS_Tb_I2_heat_3 = ssest(data_Tb_I2_heat, 3, opt_heat);
SS_Tb_I2_heat_4 = ssest(data_Tb_I2_heat, 4, opt_heat);

figure;
compare(data_Tb_I2_heat, ...
    SS_Tb_I2_heat_2, SS_Tb_I2_heat_3, SS_Tb_I2_heat_4)
grid on
title('Model Comparison: [current^2, heatpwr] to Tb')

%% Select heat power thermal model

G_Tb_I2_heat = SS_Tb_I2_heat_2;

fprintf('\n===== Selected heat power thermal model: order 2 =====\n')
disp(G_Tb_I2_heat)
fprintf('Stable = %d\n', isstable(G_Tb_I2_heat));

%% Residual analysis

figure;
resid(data_Tb_I2_heat, G_Tb_I2_heat)
title('Residual Analysis: [current^2, heatpwr] to Tb')

[yhat_Tb_I2_heat, fit_Tb_I2_heat, x0_Tb_I2_heat] = compare(data_Tb_I2_heat, G_Tb_I2_heat);

y_Tb_meas_heat = data_Tb_I2_heat.OutputData;
y_Tb_pred_heat = yhat_Tb_I2_heat.OutputData;

e_Tb_I2_heat = y_Tb_meas_heat - y_Tb_pred_heat;

RMSE_Tb_I2_heat = sqrt(mean(e_Tb_I2_heat.^2));
MAE_Tb_I2_heat  = mean(abs(e_Tb_I2_heat));
MAX_Tb_I2_heat  = max(abs(e_Tb_I2_heat));

fprintf('\n===== Heat power thermal model error metrics =====\n');
fprintf('Fit    = %.4f %%\n', fit_Tb_I2_heat);
fprintf('RMSE   = %.6f\n', RMSE_Tb_I2_heat);
fprintf('MAE    = %.6f\n', MAE_Tb_I2_heat);
fprintf('MAXERR = %.6f\n', MAX_Tb_I2_heat);

%% Residual time-series

figure;
plot(t, e_Tb_I2_heat, 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('Tb residual')
title('Residual Time Series: [current^2, heatpwr] to Tb')

figure;
plot(t, abs(e_Tb_I2_heat), 'LineWidth', 1.2)
grid on
xlabel('Time [s]')
ylabel('|Tb residual|')
title('Residual Magnitude: [current^2, heatpwr] to Tb')


%% Save selected heat power thermal model

SS_Tb_I2_heat = SS_Tb_I2_heat_2;
TF_Tb_I2_heat = tf(SS_Tb_I2_heat);

save('heatpwr_I2_heat_to_Tb_order2_blackbox_model.mat', ...
    'SS_Tb_I2_heat', ...
    'TF_Tb_I2_heat', ...
    'data_Tb_I2_heat', ...
    'Ts', ...
    'fit_Tb_I2_heat', ...
    'RMSE_Tb_I2_heat', ...
    'MAE_Tb_I2_heat', ...
    'MAX_Tb_I2_heat');

fprintf('\nSaved heat power model to heatpwr_I2_heat_to_Tb_order2_blackbox_model.mat\n');