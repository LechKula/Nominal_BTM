%% 
%rmdir("c_generated_code/", 's') % Remember to uncomment when debugging
open("Cool_and_Heat_EVBatteryCoolingSystem.slx")
T_env = 19;
T_init = T_env + 273.15;
tF =  1*2474;
t_sim = tF;
nominal = py.importlib.import_module('nominal_acados_mpc_battery');

%%
clear nominal
rmdir("c_generated_code/", 's')
nominal = py.importlib.import_module('nominal_acados_mpc_battery');

py.importlib.reload(nominal)
