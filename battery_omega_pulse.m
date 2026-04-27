%% ============================================================
%  FAN SPEED / OMEGA PULSE IDENTIFICATION
%  Subsystem:
%     [current^2, omega] -> Tb
%
%  Assumptions for this dataset:
%     heatpwr = 0
%     current = constant, e.g. 7 A
%     omega is the excitation input
%     T_env is constant
%  ============================================================

%% ------------------------------------------------------------
%  Extract data from Simulink
%  Change fan_pulse to your actual logged variable name
%  ------------------------------------------------------------

Tb       = omega_pulse.Data(:,1);
SoC      = omega_pulse.Data(:,2);
heatpwr  = omega_pulse.Data(:,3);
omega    = omega_pulse.Data(:,4);
current  = omega_pulse.Data(:,5);

Ts = 0.1;

N = length(current);
t = (0:N-1)' * Ts;

fprintf('\n===== Fan speed pulse data summary =====\n');
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
title('Raw Logged Signals: Fan Speed Pulse Test')

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
%  PART 1: MISO THERMAL MODEL [current^2, omega] -> Tb
%  ============================================================

u_Tb_I2_omega = [current.^2, omega];
y_Tb_delta_omega = Tb - Tb(1);

data_Tb_I2_omega = iddata(y_Tb_delta_omega, u_Tb_I2_omega, Ts);
data_Tb_I2_omega.InputName = {'current_squared','omega'};
data_Tb_I2_omega.OutputName = {'Tb_delta'};
data_Tb_I2_omega.TimeUnit = 'seconds';

figure;
plot(data_Tb_I2_omega)
grid on
title('Identification Data: [current^2, omega] to Tb')

%% ------------------------------------------------------------
%  Estimate MISO state-space models
%  ------------------------------------------------------------

opt_ss_Tb = ssestOptions;
opt_ss_Tb.Focus = 'simulation';
opt_ss_Tb.Display = 'on';

SS_Tb_I2_omega_1 = ssest(data_Tb_I2_omega, 1, opt_ss_Tb);
SS_Tb_I2_omega_2 = ssest(data_Tb_I2_omega, 2, opt_ss_Tb);
SS_Tb_I2_omega_3 = ssest(data_Tb_I2_omega, 3, opt_ss_Tb);
SS_Tb_I2_omega_4 = ssest(data_Tb_I2_omega, 4, opt_ss_Tb);

figure;
compare(data_Tb_I2_omega, ...
    SS_Tb_I2_omega_1, ...
    SS_Tb_I2_omega_2, ...
    SS_Tb_I2_omega_3, ...
    SS_Tb_I2_omega_4)
grid on
title('Model Comparison: [current^2, omega] to Tb')

%% Select fan-speed thermal model

G_Tb_I2_omega = SS_Tb_I2_omega_4;   % selected based on separated omega dataset

fprintf('\n===== Selected fan-speed thermal model: order 4 =====\n')
disp(G_Tb_I2_omega)
fprintf('Stable = %d\n', isstable(G_Tb_I2_omega));

%%
figure;
compare(data_Tb_I2_omega, SS_Tb_I2_omega_2, SS_Tb_I2_omega_4)
grid on
title('Order 2 vs Order 4: [current^2, omega] to Tb')

%% Residual magnitude comparison: order 2 vs order 4

models_omega = {SS_Tb_I2_omega_2, SS_Tb_I2_omega_4};
names_omega  = {'Order 2','Order 4'};

figure;
hold on
grid on

for k = 1:length(models_omega)

    [yhat_k, fit_k, ~] = compare(data_Tb_I2_omega, models_omega{k});

    y_meas_k = data_Tb_I2_omega.OutputData;
    y_pred_k = yhat_k.OutputData;

    e_k = y_meas_k - y_pred_k;

    RMSE_k = sqrt(mean(e_k.^2));
    MAE_k  = mean(abs(e_k));
    MAX_k  = max(abs(e_k));

    fprintf('\n%s residual metrics:\n', names_omega{k});
    fprintf('Fit    = %.4f %%\n', fit_k);
    fprintf('RMSE   = %.6f\n', RMSE_k);
    fprintf('MAE    = %.6f\n', MAE_k);
    fprintf('MAXERR = %.6f\n', MAX_k);

    plot(t, abs(e_k), 'LineWidth', 1.2, ...
        'DisplayName', sprintf('%s |e|', names_omega{k}));
end

xlabel('Time [s]')
ylabel('|Tb residual|')
title('Residual Magnitude Comparison: Omega Model')
legend('show')

%%

figure;
step(SS_Tb_I2_omega_2, SS_Tb_I2_omega_4)
grid on
legend('Order 2','Order 4')
title('Step Response Comparison: Omega Thermal Model')

%% Final selected omega/fan-speed model

G_Tb_I2_omega = SS_Tb_I2_omega_4;

TF_Tb_I2_omega = tf(G_Tb_I2_omega);

fprintf('\n===== Final selected fan-speed model: order 4 =====\n')
disp(G_Tb_I2_omega)
fprintf('Stable = %d\n', isstable(G_Tb_I2_omega));

save('fanspeed_I2_omega_to_Tb_order4_blackbox_model.mat', ...
    'G_Tb_I2_omega', ...
    'TF_Tb_I2_omega', ...
    'data_Tb_I2_omega', ...
    'Ts');

%%