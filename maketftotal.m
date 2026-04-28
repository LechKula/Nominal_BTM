%% ============================================================
%  BUILD COMBINED BATTERY BLACK-BOX MODEL FROM SAVED FILES
%
%  Thermal model:
%     [current^2, omega] -> Tb_delta
%
%  SoC model:
%     current -> SoC_delta
%
%  Combined model:
%     [current^2, omega, current] -> [Tb_delta, SoC_delta]
%  ============================================================

clc
clear
close all

%% ------------------------------------------------------------
%  Find data/model files in current folder
%  ------------------------------------------------------------

tf_I2_omega_2_tb = dir('fanspeed_I2_omega_to_Tb_order4_blackbox_model.mat');
tf_I_omega_2_tb_soc = dir('current_only_Tb_SoC_blackbox_models.mat');

if isempty(tf_I2_omega_2_tb)
    error('File not found: fanspeed_I2_omega_to_Tb_order4_blackbox_model.mat')
end

if isempty(tf_I_omega_2_tb_soc)
    error('File not found: current_only_Tb_SoC_blackbox_models.mat')
end

fprintf('Found thermal fan-speed model file: %s\n', tf_I2_omega_2_tb.name)
fprintf('Found current-only Tb/SoC model file: %s\n', tf_I_omega_2_tb_soc.name)

%% ------------------------------------------------------------
%  Load fan-speed thermal model
%  ------------------------------------------------------------

fan_model_file = tf_I2_omega_2_tb.name;

fan_data = load(fan_model_file);

fprintf('\nVariables in fan-speed model file:\n')
disp(fieldnames(fan_data))

% Expected variable from your save block:
% G_Tb_I2_omega or SS_Tb_I2_omega

if isfield(fan_data, 'G_Tb_I2_omega')
    G_Tb_I2_omega = fan_data.G_Tb_I2_omega;
elseif isfield(fan_data, 'SS_Tb_I2_omega')
    G_Tb_I2_omega = fan_data.SS_Tb_I2_omega;
elseif isfield(fan_data, 'SS_Tb_I2_omega_4')
    G_Tb_I2_omega = fan_data.SS_Tb_I2_omega_4;
else
    error('Could not find G_Tb_I2_omega / SS_Tb_I2_omega / SS_Tb_I2_omega_4 in fan model file.')
end

fprintf('\nLoaded thermal model: [current^2, omega] -> Tb_delta\n')
disp(G_Tb_I2_omega)

%% ------------------------------------------------------------
%  Load current-only SoC model
%  ------------------------------------------------------------

current_model_file = tf_I_omega_2_tb_soc.name;

current_data = load(current_model_file);

fprintf('\nVariables in current-only model file:\n')
disp(fieldnames(current_data))

% Expected variable from your save block:
% G_SoC_current or SS_SoC_current_1

if isfield(current_data, 'G_SoC_current')
    G_SoC_current = current_data.G_SoC_current;
elseif isfield(current_data, 'SS_SoC_current_1')
    G_SoC_current = current_data.SS_SoC_current_1;
elseif isfield(current_data, 'SS_SoC_current')
    G_SoC_current = current_data.SS_SoC_current;
else
    error('Could not find G_SoC_current / SS_SoC_current_1 / SS_SoC_current in current model file.')
end

fprintf('\nLoaded SoC model: current -> SoC_delta\n')
disp(G_SoC_current)

%% ------------------------------------------------------------
%  Convert subsystem models to state-space
%  ------------------------------------------------------------

G_Tb_I2_omega_ss = ss(G_Tb_I2_omega);
G_SoC_current_ss = ss(G_SoC_current);

% Name thermal model I/O
G_Tb_I2_omega_ss.InputName  = {'current_squared','omega'};
G_Tb_I2_omega_ss.OutputName = {'Tb_delta'};

% Name SoC model I/O
G_SoC_current_ss.InputName  = {'current'};
G_SoC_current_ss.OutputName = {'SoC_delta'};

%% ------------------------------------------------------------
%  Build combined state-space model
%  ------------------------------------------------------------

SS_battery_combined = append(G_Tb_I2_omega_ss, G_SoC_current_ss);

SS_battery_combined.InputName  = {'current_squared','omega','current'};
SS_battery_combined.OutputName = {'Tb_delta','SoC_delta'};

fprintf('\n===== Combined battery black-box state-space model =====\n')
disp(SS_battery_combined)

fprintf('Stable = %d\n', isstable(SS_battery_combined))

%% ------------------------------------------------------------
%  Convert to transfer-function matrix
%  ------------------------------------------------------------

TF_battery_combined = tf(SS_battery_combined);

fprintf('\n===== Combined battery transfer-function matrix =====\n')
disp(TF_battery_combined)
