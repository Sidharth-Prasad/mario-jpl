function Q_heater = heater(alpha_MLI, eps_MLI, alpha_rad, eps_rad, ...
    alpha_patch, eps_patch, alpha_prop, eps_prop, alpha_ant1, eps_ant1, alpha_ant2, eps_ant2,...
    A_zenit_MLI, A_patch, A_nadir_MLI, A_rad, A_sun, A_antisun, A_ram_MLI, A_prop, A_ant1, A_ant2, ...
    T, Q_gen, q_zenit, ...
    q_nadir_solar, q_nadir_albedo, q_nadir_IR, ...
    q_sun_solar, q_sun_albedo, q_sun_IR, ...
    q_antisun_solar, q_antisun_albedo, q_antisun_IR, ...
    q_ram_solar, q_ram_albedo, q_ram_IR) 
sigma = 5.670374419e-8;
Q_zenit = q_zenit * (alpha_MLI * A_zenit_MLI + alpha_patch * A_patch);
Q_nadir = (q_nadir_solar + q_nadir_albedo + q_nadir_IR) * (alpha_MLI * A_nadir_MLI + alpha_rad * A_rad);
Q_sun = (q_sun_solar + q_sun_albedo + q_sun_IR) * alpha_MLI * A_sun;
Q_antisun = (q_antisun_solar + q_antisun_albedo + q_antisun_IR) * A_antisun * alpha_MLI;
Q_ram_1 = (q_ram_solar + q_ram_albedo + q_ram_IR) * (A_ant1 * alpha_ant1 + A_ant2 * alpha_ant2);
Q_ram_2 = (q_ram_solar + q_ram_albedo + q_ram_IR) * (A_ram_MLI * alpha_MLI + A_prop * alpha_prop);

Q_in = Q_zenit + Q_nadir + Q_sun + Q_antisun + Q_ram_1 + Q_ram_2 + Q_gen;
A_MLI = A_zenit_MLI + A_nadir_MLI + A_sun + A_antisun + A_ram_MLI;

Q_out = sigma*T^4*(eps_rad*A_rad+eps_MLI*A_MLI+eps_patch*A_patch+eps_ant1*A_ant1+eps_ant2*A_ant2+A_prop*eps_prop);

Q_heater = Q_out - Q_in;

if Q_heater<0
    Q_heater = 0;
    T_balance = (Q_in/(sigma*(eps_rad*A_rad+eps_patch*A_patch+eps_MLI*A_MLI+...
    A_prop*eps_prop+A_ant1*eps_ant1+A_ant2*eps_ant2)))^(1/4)-273.15;
    fprintf("Heater unnecessary: balance T = %g C\n",T_balance)
end
end