clear
clc
close all

%% Material and Environmental Properties

% UPDATE PARAMETERS BASED OFF OF RENNO PAPER AND TRY OUT VARIOUS
% INSULATIONS
a_mli = 0.1;
e_mli = 0.02;
a_rad = 0.15;
e_rad = 0.8;
area_rad = 0.035;
mars_bond_albedo = 0.25;
geom_albedo = 0.17;
sigma = 5.67e-8;

sol_irr = 586.2; % w/m^2
bb_temp = 209.8; % K
% dimensions 6u 10*20*30 cm
pow_eff = 0.15;
power_in = 67.9;
Q_internal = power_in*pow_eff

area_6u = [0.02; 0.02; 0.03; 0.03; 0.06; 0.06]; %m^2 [zenith, nadir, sun, antisun, +ram, -ram]

hot_case_temp = 40+273.15; % K
cold_case_temp = 0+273.15; % K
% no Beta angle


%% Case Case
q_albedo = mars_bond_albedo*sol_irr;
q_IR = sigma*bb_temp^4;
q_sun = sol_irr;

Q_in = q_sun*area_6u(5)*a_mli + q_albedo*sum(area_6u)/2*a_mli + q_IR*sum(area_6u)/2*e_mli+Q_internal;
Q_out = sigma*hot_case_temp^4*e_mli*sum(area_6u-area_rad) + sigma*hot_case_temp^4*e_rad*sum(area_rad);

Q_tot = Q_in-Q_out

%% Kek Case\
q_albedo = mars_bond_albedo*sol_irr;
q_IR = sigma*bb_temp^4;
q_sun = sol_irr;

Q_in = q_sun*area_6u(5)*a_mli + q_albedo*sum(area_6u)/2*a_mli + q_IR*sum(area_6u)/2*e_mli+Q_internal;
Q_out = sigma*cold_case_temp^4*e_mli*sum(area_6u-area_rad) + sigma*hot_case_temp^4*e_rad*sum(area_rad);

Q_tot_cold = Q_in-Q_out

%% Cold Case (-10 + 10 = 0 C)
alpha = @(eps) (sigma*hot_case_temp^4*sum(area_6u) - q_IR*sum(area_6u)/2)/(q_sun*area_6u(3) + q_albedo*sum(area_6u)/2) * eps;

eps = 0.1:0.01:0.8;
a = 0.05:0.001:0.1;
Q_total = zeros(length(eps),length(a));

for i = 1:1:length(eps)
    for j = 1:1:length(a)
        Q_in = q_sun*area_6u(3)*a(j) + q_albedo*sum(area_6u)/2*a(j) + q_IR*sum(area_6u)/2*eps(i);
        Q_out = sigma*hot_case_temp^4*eps(i)*sum(area_6u);
        Q_total(i,j) = Q_in-Q_out;
    end 
end

figure
surf(Q_total)
xlabel("\epsilon");
ylabel("\alpha");
zlabel("Q Def");

    
%% Hot Case (50 - 10 = 40 C)