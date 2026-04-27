
% prepare data for freq
t_raw   = I_log.Time;
I_raw   = I_log.Data;
Tb_raw  = Tb_log.Data;
SoC_raw = SoC_log.Data;


Ts = 0.1;   % final identification sample time
t = (t_raw(1):Ts:t_raw(end))';
I   = interp1(t_raw, I_raw,   t, 'linear');
Tb  = interp1(t_raw, Tb_raw,  t, 'linear');
SoC = interp1(t_raw, SoC_raw, t, 'linear');

data_Tb  = iddata(Tb,  I, Ts);
data_SOC = iddata(SoC, I, Ts);

% data prechecks run to chekc the consisitency after fixed sampling 

pre_check = false ;

if pre_check == true

    figure;
    subplot(3,1,1)
    plot(t,I), grid on
    ylabel('Current [A]')
    
    subplot(3,1,2)
    plot(t,Tb), grid on
    ylabel('Tb')
    
    subplot(3,1,3)
    plot(t,SoC), grid on
    ylabel('SoC')
    xlabel('Time [s]')
end

% remove the offsets 

data_Tb_d  = detrend(data_Tb, 0);
data_SOC_d = detrend(data_SOC, 0);

% split est and val data 

t_val_start = 2000;   % change this to your second bump start time

idx_est = t < t_val_start;
idx_val = t >= t_val_start;

data_Tb_est  = data_Tb_d(idx_est, :, :);
data_Tb_val  = data_Tb_d(idx_val, :, :);

data_SOC_est = data_SOC_d(idx_est, :, :);
data_SOC_val = data_SOC_d(idx_val, :, :);

figure;
plot(data_Tb_d)
title('Detrended Tb Identification Data')

figure;
plot(data_SOC_d)
title('Detrended SoC Identification Data')


%% model guess and fit

G_Tb_1  = tfest(data_Tb_est, 1, 0);   % 1 pole
G_Tb_2  = tfest(data_Tb_est, 2, 0);   % 2 poles
G_Tb_2z = tfest(data_Tb_est, 2, 1);   % 2 poles, 1 zero


%% modle check 
figure;
compare(data_Tb_val, G_Tb_1, G_Tb_2, G_Tb_2z);
grid on;
title('Tb Model Validation');

%%

G_Tb_3z1 = tfest(data_Tb_est, 3, 1);
G_Tb_3z2 = tfest(data_Tb_est, 3, 2);
G_Tb_4z2 = tfest(data_Tb_est, 4, 2);

%%
figure;
compare(data_Tb_val, G_Tb_2z, G_Tb_3z1, G_Tb_3z2, G_Tb_4z2);
grid on;
title('Tb Model Validation - Higher Order TFs');


%%

G_Tb = G_Tb_4z2;

disp(G_Tb)

p = pole(G_Tb);
z = zero(G_Tb);

disp('Poles:')
disp(p)

disp('Zeros:')
disp(z)

disp('Is stable?')
disp(isstable(G_Tb))

figure;
pzmap(G_Tb)
grid on
title('Pole-Zero Map of Selected Tb Model')

%%
figure;
compare(data_Tb_val, G_Tb);
grid on;
title('Selected Tb Model Validation')

%% residual 

figure;
resid(data_Tb_val, G_Tb);
grid on;
title('Residual Analysis for Selected Tb Model')