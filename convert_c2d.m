%% Force final model into discrete-time form for Simulink Discrete State-Space

load('battery_final_portable_mux_demux_model.mat')

Ts_model = 0.1;   % your identification/sample time

% Convert final model to ordinary state-space
sys_cont_or_disc = ss(SS_final);

% If continuous, discretize it
if sys_cont_or_disc.Ts == 0
    battery_sys_d = c2d(sys_cont_or_disc, Ts_model, 'zoh');
else
    battery_sys_d = sys_cont_or_disc;
    battery_sys_d.Ts = Ts_model;
end

% Extract DISCRETE matrices
A_d = battery_sys_d.A;
B_d = battery_sys_d.B;
C_d = battery_sys_d.C;
D_d = battery_sys_d.D;

Ts_d = battery_sys_d.Ts;
nx_d = size(A_d,1);

save('battery_final_discrete_for_simulink.mat', ...
    'battery_sys_d', ...
    'A_d', 'B_d', 'C_d', 'D_d', ...
    'Ts_d', 'nx_d');

fprintf('Saved discrete model for Simulink.\n')
fprintf('Ts_d = %.4f\n', Ts_d)
