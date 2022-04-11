clear
close all
clc

%% Orbit and S/C data
elevation = 2500; % orbit elevation [km]

A_patch = 68275e-6; % area of the Ka antenna [m^2]
alpha_patch_BOL = 0.15; % BOL absorptivity of Ka antenna
alpha_patch_EOL = 0.30; % EOL absorptivity of Ka antenna
eps_patch_BOL = 0.03; % BOL emissivity of Ka antenna
eps_patch_EOL = 0.15; % BOL emissivity of Ka antenna
A_ant1 = 82.6e-3*98e-3; % area of the X antenna [m^2]
Agold = 8.76e-3^2*16; % area of the golden squares of X antenna [m^2]
alphagBOL = 0.2; % BOL absorptivity of the golden squares of X antenna
alphagEOL = 0.2; % EOL absorptivity of the golden squares of X antenna
epsgBOL = 0.03; % BOL emissivity of the golden squares of X antenna
epsgEOL = 0.03; % EOL emissivity of the golden squares of X antenna
Awp = A_ant1-Agold; % area of the white paint of X antenna [m^2]
alphawpBOL = 0.25; % BOL absorptivity of the white paint of X antenna
alphawpEOL = 0.40; % EOL absorptivity of the white paint of X antenna
epswpBOL = 0.8; % BOL emissivity of the white paint of X antenna
epswpEOL = 0.8; % EOL emissivity of the white paint of X antenna
alpha_ant1_BOL = Agold/A_ant1*alphagBOL + Awp/A_ant1*alphawpBOL; % averaged BOL absorptivity of X antenna
alpha_ant1_EOL = Agold/A_ant1*alphagEOL + Awp/A_ant1*alphawpEOL; % averaged EOL absorptivity of X antenna
eps_ant1_BOL = Agold/A_ant1*epsgBOL + Awp/A_ant1*epswpBOL; % averaged BOL emissivity of X antenna
eps_ant1_EOL= Agold/A_ant1*epsgEOL + Awp/A_ant1*epswpEOL; % averaged EOL emissivity of X antenna
A_ant2 = 0.02-A_ant1; % area of the UHF antenna [m^2]
alpha_ant2_BOL = alphagBOL; % BOL absorptivity of UHF antenna
alpha_ant2_EOL = alphagEOL; % EOL absorptivity of UHF antenna
eps_ant2_BOL = epsgBOL; % BOL emissivity of UHF antenna
eps_ant2_EOL = alphagEOL; % EOL emissivity of UHF antenna
A_prop = 9e-4;
alpha_prop_BOL = alpha_patch_BOL; % BOL absorptivity of propulsion exhaust
alpha_prop_EOL = alpha_patch_EOL; % EOL absorptivity of propulsion exhaust
eps_prop_BOL = eps_patch_BOL; % BOL emissivity of propulsion exhaust
eps_prop_EOL = eps_patch_EOL; % BOL emissivity of propulsion exhaust


Faces = [0.02; 0.03; 0.06]; % faces of the satellite [m^2]

A_zenit = 5000e-6; % MLI zenith covered surface [m^2]
A_nadir = Faces(3); % Nadir surface [m^2]
A_antisun = Faces(2); % Antisun surface [m^2]
A_sun = Faces(2); % Sun covered surface [m^2]
A_ram = Faces(1)-A_prop; % MLI ram covered surface [m^2]

T_hot = 50+273.15-10; % maximum operational temperature - margin [K]
Q_gen_hot = xlsread('EPS.xlsx','C11:C11'); % heat waste (w/ margin) [W]
T_cold = -10+273.15+10; % minimum operational temperature + margin [K]
Q_gen_cold = xlsread('EPS.xlsx','C10:C10');  % heat waste (w/o margin) [W]
T_survival = -20+273.15+10; % minimum survival temperature + margin [W]
Q_gen_survival = xlsread('EPS.xlsx','G10:G10'); % heat waste in survival mode (w/o margin) [W]

%% Materials
alpha_MLI_BOL = 0.93; % BOL MLI absorptance
alpha_MLI_EOL = 0.93; % EOL MLI absorptance
eps_MLI_BOL = 0.84; % BOL MLI emissivity
eps_MLI_EOL = 0.84; % EOL MLI emissivity
alpha_rad_BOL = 0.09; % BOL radiator absorptance
alpha_rad_EOL = 0.25; % EOL radiator absorptance
eps_rad_BOL = 0.90; % BOL radiator emissivity
eps_rad_EOL = 0.90; % EOL radiator emissivity

%% Radiator

% Earth heat fluxes - hot case
[q_zenit_hot, q_nadir_solar_hot, q_nadir_albedo_hot, q_nadir_IR_hot, ...
    q_sun_solar_hot, q_sun_albedo_hot, q_sun_IR_hot, ...
    q_antisun_solar_hot, q_antisun_albedo_hot, q_antisun_IR_hot, ...
    q_ram_solar_hot, q_ram_albedo_hot, q_ram_IR_hot] = heat_hot(elevation);
% Mars/Earth conversion (https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html)
q_zenit_hot = q_zenit_hot/1.52^2;
q_nadir_solar_hot = q_nadir_solar_hot/1.52^2;
q_sun_solar_hot = q_sun_solar_hot/1.52^2;
q_antisun_solar_hot = q_antisun_solar_hot/1.52^2;
q_ram_solar_hot = q_ram_solar_hot/1.52^2;
q_nadir_albedo_hot = q_nadir_albedo_hot*0.817;
q_sun_albedo_hot = q_sun_albedo_hot*0.817;
q_antisun_albedo_hot = q_antisun_albedo_hot*0.817;
q_ram_albedo_hot = q_ram_albedo_hot*0.817;
q_nadir_IR_hot = q_nadir_IR_hot*0.826^4;
q_sun_IR_hot = q_sun_IR_hot*0.826^4;
q_antisun_IR_hot = q_antisun_IR_hot*0.826^4;
q_ram_IR_hot = q_ram_IR_hot*0.826^4;

A_rad = zeros(length(q_zenit_hot),1);
for ii = 1:length(q_zenit_hot)
    A_rad(ii) = radiator(alpha_MLI_EOL, eps_MLI_EOL, alpha_rad_EOL, eps_rad_EOL, ...
        alpha_patch_EOL, eps_patch_EOL, alpha_prop_EOL, eps_prop_EOL, alpha_ant1_EOL, eps_ant1_EOL, alpha_ant2_EOL, eps_ant2_EOL, ...
        A_zenit, A_patch, A_nadir, A_antisun, A_sun, A_ram, A_prop, A_ant1, A_ant2, ...
        T_hot, Q_gen_hot, q_zenit_hot(ii), ...
        q_nadir_solar_hot(ii), q_nadir_albedo_hot(ii), q_nadir_IR_hot(ii), ...
        q_sun_solar_hot(ii), q_sun_albedo_hot(ii), q_sun_IR_hot(ii), ...
        q_antisun_solar_hot(ii), q_antisun_albedo_hot(ii), q_antisun_IR_hot(ii), ...
        q_ram_solar_hot(ii), q_ram_albedo_hot(ii), q_ram_IR_hot(ii));
end
A_rad = max(A_rad) % radiator surface [m^2]
A_nadir_MLI = A_nadir - A_rad; % nadir surface covered by MLI [m^2]
A_rad*2700*0.5e-3*2
(A_nadir_MLI + A_zenit + A_patch + A_antisun + A_sun + A_ram)*1e4*0.006985*1.41*2
%% Heater

% Earth heat fluxes - cold case
[q_zenit_cold, q_nadir_solar_cold, q_nadir_albedo_cold, q_nadir_IR_cold, ...
    q_sun_solar_cold, q_sun_albedo_cold, q_sun_IR_cold, ...
    q_antisun_solar_cold, q_antisun_albedo_cold, q_antisun_IR_cold, ...
    q_ram_solar_cold, q_ram_albedo_cold, q_ram_IR_cold] = heat_cold(elevation);
% Mars/Earth conversion (https://nssdc.gsfc.nasa.gov/planetary/factsheet/marsfact.html)
q_zenit_cold = q_zenit_cold/1.52^2;
q_nadir_solar_cold = q_nadir_solar_cold/1.52^2;
q_sun_solar_cold = q_sun_solar_cold/1.52^2;
q_antisun_solar_cold = q_antisun_solar_cold/1.52^2;
q_ram_solar_cold = q_ram_solar_cold/1.52^2;
q_nadir_albedo_cold = q_nadir_albedo_cold*0.817;
q_sun_albedo_cold = q_sun_albedo_cold*0.817;
q_antisun_albedo_cold = q_antisun_albedo_cold*0.817;
q_ram_albedo_cold = q_ram_albedo_cold*0.817;
q_nadir_IR_cold = q_nadir_IR_cold*0.826^4;
q_sun_IR_cold = q_sun_IR_cold*0.826^4;
q_antisun_IR_cold = q_antisun_IR_cold*0.826^4;
q_ram_IR_cold = q_ram_IR_cold*0.826^4;

Q_heater = zeros(length(q_zenit_cold),1);
for ii = 1:length(q_zenit_cold)
    Q_heater(ii) = heater(alpha_MLI_BOL, eps_MLI_BOL, alpha_rad_BOL, eps_rad_BOL, ...
        alpha_patch_BOL, eps_patch_BOL, alpha_prop_BOL, eps_prop_BOL, alpha_ant1_BOL, eps_ant1_BOL, alpha_ant2_BOL, eps_ant2_BOL, ...
        A_zenit, A_patch, A_nadir_MLI, A_rad, A_sun, A_antisun, A_ram, A_prop, A_ant1, A_ant2, ...
        T_cold, Q_gen_cold, q_zenit_cold(ii), ...
        q_nadir_solar_cold(ii), q_nadir_albedo_cold(ii), q_nadir_IR_cold(ii), ...
        q_sun_solar_cold(ii), q_sun_albedo_cold(ii), q_sun_IR_cold(ii), ...
        q_antisun_solar_cold(ii), q_antisun_albedo_cold(ii), q_antisun_IR_cold(ii), ...
        q_ram_solar_cold(ii), q_ram_albedo_cold(ii), q_ram_IR_cold(ii));
end
Q_heater = max(Q_heater) % heat required from heater [W]
if Q_heater < 0
    Q_heater = 0;
end

Q_survival_heater = zeros(length(q_zenit_cold),1);
for ii = 1:length(q_zenit_cold)
    Q_survival_heater(ii) = heater(alpha_MLI_BOL, eps_MLI_BOL, alpha_rad_BOL, eps_rad_BOL, ...
        alpha_patch_BOL, eps_patch_BOL, alpha_prop_BOL, eps_prop_BOL, alpha_ant1_BOL, eps_ant1_BOL, alpha_ant2_BOL, eps_ant2_BOL, ...
        A_zenit, A_patch, A_nadir_MLI, A_rad, A_sun, A_antisun, A_ram, A_prop, A_ant1, A_ant2, ...
        T_survival, Q_gen_survival, q_zenit_cold(ii), ...
        q_nadir_solar_cold(ii), q_nadir_albedo_cold(ii), q_nadir_IR_cold(ii), ...
        q_sun_solar_cold(ii), q_sun_albedo_cold(ii), q_sun_IR_cold(ii), ...
        q_antisun_solar_cold(ii), q_antisun_albedo_cold(ii), q_antisun_IR_cold(ii), ...
        q_ram_solar_cold(ii), q_ram_albedo_cold(ii), q_ram_IR_cold(ii));
end
Q_survival_heater = max(Q_survival_heater)-Q_heater; % additional heat required from survival heater [W]
if Q_survival_heater < 0
    fprintf('\nNo additional heat required for survival mode\n')
    Q_survival_heater = 0;
else
    fprintf('\nAdditional heat for survival mode: %g W\n',Q_survival_heater)
end

Q_heater_complete = Q_heater + Q_survival_heater; % overall heat required [W]

if elevation == 400
    save('Q_heater_in',"Q_heater_complete")
elseif elevation == 2500
    save('Q_heater_out',"Q_heater_complete")
end