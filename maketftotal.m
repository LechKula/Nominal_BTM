%% ============================================================
%  BUILD COMBINED BATTERY BLACK-BOX MODEL FROM SAVED FILES
%
%  Thermal models:
%     fan-speed model:  [current^2, omega]   -> Tb_delta
%     heatpwr model:    [current^2, heatpwr] -> Tb_delta
%
%  SoC model:
%     current -> SoC_delta
%
%  Final combined model:
%     [current^2, omega, current, heatpwr] -> [Tb_delta, SoC_delta]
%
%  Important:
%     current^2 appears in both thermal models.
%     We use the current^2 path from the fan-speed model only.
%     We use only the heatpwr path from the heat-power model.
%  ============================================================

clc
clear
close all

%% ------------------------------------------------------------
%  Find model files in current folder
%  ------------------------------------------------------------

tf_I2_omega_2_tb = dir('fanspeed_I2_omega_to_Tb_order4_blackbox_model.mat');
tf_I_current_2_tb_soc = dir('current_only_Tb_SoC_blackbox_models.mat');
tf_I2_heat_2_tb = dir('heatpwr_I2_heat_to_Tb_order2_blackbox_model.mat');

if isempty(tf_I2_omega_2_tb)
    error('File not found: fanspeed_I2_omega_to_Tb_order4_blackbox_model.mat')
end

if isempty(tf_I_current_2_tb_soc)
    error('File not found: current_only_Tb_SoC_blackbox_models.mat')
end

if isempty(tf_I2_heat_2_tb)
    error('File not found: heatpwr_I2_heat_to_Tb_order2_blackbox_model.mat')
end

fprintf('Found fan-speed thermal model file: %s\n', tf_I2_omega_2_tb.name)
fprintf('Found current-only Tb/SoC model file: %s\n', tf_I_current_2_tb_soc.name)
fprintf('Found heat-power thermal model file: %s\n', tf_I2_heat_2_tb.name)

%% ------------------------------------------------------------
%  Load fan-speed thermal model: [current^2, omega] -> Tb_delta
%  ------------------------------------------------------------

fan_model_file = tf_I2_omega_2_tb.name;
fan_data = load(fan_model_file);

fprintf('\nVariables in fan-speed model file:\n')
disp(fieldnames(fan_data))

if isfield(fan_data, 'G_Tb_I2_omega')
    G_Tb_I2_omega = fan_data.G_Tb_I2_omega;
elseif isfield(fan_data, 'SS_Tb_I2_omega')
    G_Tb_I2_omega = fan_data.SS_Tb_I2_omega;
elseif isfield(fan_data, 'SS_Tb_I2_omega_4')
    G_Tb_I2_omega = fan_data.SS_Tb_I2_omega_4;
else
    error('Could not find fan-speed thermal model in fan model file.')
end

G_Tb_I2_omega_ss = ss(G_Tb_I2_omega);
G_Tb_I2_omega_ss.InputName  = {'current_squared','omega'};
G_Tb_I2_omega_ss.OutputName = {'Tb_delta'};

fprintf('\nLoaded fan-speed thermal model: [current^2, omega] -> Tb_delta\n')
disp(G_Tb_I2_omega_ss)

%% ------------------------------------------------------------
%  Load heat-power thermal model: [current^2, heatpwr] -> Tb_delta
%  ------------------------------------------------------------

heat_model_file = tf_I2_heat_2_tb.name;
heat_data = load(heat_model_file);

fprintf('\nVariables in heat-power model file:\n')
disp(fieldnames(heat_data))

if isfield(heat_data, 'G_Tb_I2_heat')
    G_Tb_I2_heat = heat_data.G_Tb_I2_heat;
elseif isfield(heat_data, 'SS_Tb_I2_heat')
    G_Tb_I2_heat = heat_data.SS_Tb_I2_heat;
elseif isfield(heat_data, 'SS_Tb_I2_heat_2')
    G_Tb_I2_heat = heat_data.SS_Tb_I2_heat_2;
else
    error('Could not find heat-power thermal model in heat model file.')
end

G_Tb_I2_heat_ss = ss(G_Tb_I2_heat);
G_Tb_I2_heat_ss.InputName  = {'current_squared','heatpwr'};
G_Tb_I2_heat_ss.OutputName = {'Tb_delta'};

fprintf('\nLoaded heat-power thermal model: [current^2, heatpwr] -> Tb_delta\n')
disp(G_Tb_I2_heat_ss)

%% ------------------------------------------------------------
%  Load current-only SoC model: current -> SoC_delta
%  ------------------------------------------------------------

current_model_file = tf_I_current_2_tb_soc.name;
current_data = load(current_model_file);

fprintf('\nVariables in current-only model file:\n')
disp(fieldnames(current_data))

if isfield(current_data, 'G_SoC_current')
    G_SoC_current = current_data.G_SoC_current;
elseif isfield(current_data, 'SS_SoC_current_1')
    G_SoC_current = current_data.SS_SoC_current_1;
elseif isfield(current_data, 'SS_SoC_current')
    G_SoC_current = current_data.SS_SoC_current;
else
    error('Could not find SoC current model in current model file.')
end

G_SoC_current_ss = ss(G_SoC_current);
G_SoC_current_ss.InputName  = {'current'};
G_SoC_current_ss.OutputName = {'SoC_delta'};

fprintf('\nLoaded SoC model: current -> SoC_delta\n')
disp(G_SoC_current_ss)

%% ------------------------------------------------------------
%  Extract individual thermal transfer paths
%  ------------------------------------------------------------
% Fan model inputs:
%   1 = current_squared
%   2 = omega
%
% Heat model inputs:
%   1 = current_squared
%   2 = heatpwr
%
% To avoid double-counting current_squared, use:
%   current_squared path from fan model
%   omega path from fan model
%   heatpwr path from heat model

TF_Tb_I2_omega = tf(G_Tb_I2_omega_ss);
TF_Tb_I2_heat  = tf(G_Tb_I2_heat_ss);

G_Tb_from_I2      = TF_Tb_I2_omega(1,1);
G_Tb_from_omega   = TF_Tb_I2_omega(1,2);
G_Tb_from_heatpwr = TF_Tb_I2_heat(1,2);

fprintf('\n===== Thermal transfer paths selected =====\n')

fprintf('\nTb_delta / current_squared:\n')
disp(G_Tb_from_I2)

fprintf('\nTb_delta / omega:\n')
disp(G_Tb_from_omega)

fprintf('\nTb_delta / heatpwr:\n')
disp(G_Tb_from_heatpwr)

%% ------------------------------------------------------------
%  Build full thermal MISO model:
%     [current_squared, omega, heatpwr] -> Tb_delta
%  ------------------------------------------------------------

TF_Tb_full = [G_Tb_from_I2, G_Tb_from_omega, G_Tb_from_heatpwr];

TF_Tb_full.InputName  = {'current_squared','omega','heatpwr'};
TF_Tb_full.OutputName = {'Tb_delta'};

SS_Tb_full = ss(TF_Tb_full);

SS_Tb_full.InputName  = {'current_squared','omega','heatpwr'};
SS_Tb_full.OutputName = {'Tb_delta'};

fprintf('\n===== Full thermal model =====\n')
disp(SS_Tb_full)

fprintf('Thermal model stable = %d\n', isstable(SS_Tb_full))

%% ------------------------------------------------------------
%  Build final combined battery model
%
%  Desired final input order:
%     1 current_squared
%     2 omega
%     3 current
%     4 heatpwr
%
%  Outputs:
%     1 Tb_delta
%     2 SoC_delta
%  ------------------------------------------------------------

SS_tmp = append(SS_Tb_full, G_SoC_current_ss);

% append input order is:
%   [current_squared, omega, heatpwr, current]
%
% Reorder to desired:
%   [current_squared, omega, current, heatpwr]

SS_battery_combined = SS_tmp(:, {'current_squared','omega','current','heatpwr'});

SS_battery_combined.InputName  = {'current_squared','omega','current','heatpwr'};
SS_battery_combined.OutputName = {'Tb_delta','SoC_delta'};

fprintf('\n===== Combined battery black-box state-space model =====\n')
disp(SS_battery_combined)

fprintf('Combined model stable = %d\n', isstable(SS_battery_combined))

%% ------------------------------------------------------------
%  Convert to transfer-function matrix
%  ------------------------------------------------------------

TF_battery_combined = tf(SS_battery_combined);

fprintf('\n===== Combined battery transfer-function matrix =====\n')
disp(TF_battery_combined)

fprintf('\nExpected transfer matrix structure:\n')
fprintf('                 current_squared       omega          current        heatpwr\n')
fprintf('Tb_delta              G11                G12              0             G14\n')
fprintf('SoC_delta              0                  0              G23             0\n')

%% ------------------------------------------------------------
%  Extract final individual paths for inspection
%  ------------------------------------------------------------

G_final_Tb_from_I2      = TF_battery_combined(1,1);
G_final_Tb_from_omega   = TF_battery_combined(1,2);
G_final_Tb_from_current = TF_battery_combined(1,3);
G_final_Tb_from_heatpwr = TF_battery_combined(1,4);

G_final_SoC_from_I2      = TF_battery_combined(2,1);
G_final_SoC_from_omega   = TF_battery_combined(2,2);
G_final_SoC_from_current = TF_battery_combined(2,3);
G_final_SoC_from_heatpwr = TF_battery_combined(2,4);

fprintf('\n===== Final individual transfer paths =====\n')

fprintf('\nTb_delta / current_squared:\n')
disp(G_final_Tb_from_I2)

fprintf('\nTb_delta / omega:\n')
disp(G_final_Tb_from_omega)

fprintf('\nTb_delta / heatpwr:\n')
disp(G_final_Tb_from_heatpwr)

fprintf('\nSoC_delta / current:\n')
disp(G_final_SoC_from_current)

%% ------------------------------------------------------------
%  Optional step-response checks
%  ------------------------------------------------------------

figure;
step(G_final_Tb_from_I2)
grid on
title('Step Response: current^2 to Tb_delta')

figure;
step(G_final_Tb_from_omega)
grid on
title('Step Response: omega to Tb_delta')

figure;
step(G_final_Tb_from_heatpwr)
grid on
title('Step Response: heatpwr to Tb_delta')

figure;
step(G_final_SoC_from_current)
grid on
title('Step Response: current to SoC_delta')

%% ------------------------------------------------------------
%  Save final combined model
%  ------------------------------------------------------------

save('battery_combined_blackbox_with_heatpwr_TF_SS_model.mat', ...
    'SS_battery_combined', ...
    'TF_battery_combined', ...
    'SS_Tb_full', ...
    'TF_Tb_full', ...
    'G_Tb_I2_omega', ...
    'G_Tb_I2_heat', ...
    'G_SoC_current', ...
    'G_Tb_from_I2', ...
    'G_Tb_from_omega', ...
    'G_Tb_from_heatpwr', ...
    'G_final_Tb_from_I2', ...
    'G_final_Tb_from_omega', ...
    'G_final_Tb_from_heatpwr', ...
    'G_final_SoC_from_current');

fprintf('\nSaved final combined model to battery_combined_blackbox_with_heatpwr_TF_SS_model.mat\n')