# Python code and Simulink model for BTM
Authors: Daniel McCauley, Lech Kula

# Notes
- Current is read from a CSV file so that the MPC has access to future current values when planning. If desired this can be replaced by letting current be constant during prediction horizon. Should still have decent performance.
- The directory "c_generated_code" should be removed if changes are made to the ACADOS model. (The behaviour is weird but we believe this is best for sanity)
- Sampling frequency in the Python Code Block should be the same as the dt variable 
- MATLAB is weird in how it reads python files. Need to run "import_and_clear_python_function.m" script if changes are made to the Python code (first block is to open the simulator, second block should be rerun after changes are made)
- Have to manually set T_env in Python Code Block if this is changed.
- T_env should be in Celsius, T_init in Kelvin
- EV_Extended includes the same drive cycle as EVBatteryCoolingSystem but repeated 13 times. 
- If changes are made to the model, then these changes need to be repeated in the "get_cost_to_go" and "optimization_problem_steady_state" functions as well. 
- Control variables Q_heat and omega are scaled.
- Warm start the simulation. Can be removed by changing T_warmstart to 0

# Overview
- Model in BatteryDynamics.model
- Steady state target input problem defined in BatteryDynamics.optimization_problem_steady_state
- OCP defined in MPC.ocp