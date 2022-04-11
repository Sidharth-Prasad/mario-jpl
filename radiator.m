function A_rad = radiator(alpha_MLI, eps_MLI, alpha_rad, eps_rad, ...
    alpha_patch, eps_patch, alpha_prop, eps_prop, alpha_ant1, eps_ant1, alpha_ant2, eps_ant2, ...
    A_zenit_MLI, A_patch, A_nadir, A_antisun, A_sun, A_ram_MLI, A_prop, A_ant1, A_ant2, ...
    T, Q_gen, q_zenit, ...
    q_nadir_solar, q_nadir_albedo, q_nadir_IR, ...
    q_sun_solar, q_sun_albedo, q_sun_IR, ...
    q_antisun_solar, q_antisun_albedo, q_antisun_IR, ...
    q_ram_solar, q_ram_albedo, q_ram_IR) 
sigma = 5.670374419e-8;
Q_zenit = q_zenit * (alpha_MLI * A_zenit_MLI + alpha_patch * A_patch);
Q_sun = (q_sun_solar + q_sun_albedo + q_sun_IR) * alpha_MLI * A_sun;
Q_antisun = (q_antisun_solar + q_antisun_albedo + q_antisun_IR) * A_antisun * alpha_MLI;
Q_ram_1 = (q_ram_solar + q_ram_albedo + q_ram_IR) * (A_ant1 * alpha_ant1 + A_ant2 * alpha_ant2);
Q_ram_2 = (q_ram_solar + q_ram_albedo + q_ram_IR) * (A_ram_MLI * alpha_MLI + A_prop * alpha_prop);

Q_in = Q_zenit + Q_sun + Q_antisun + Q_ram_1 + Q_ram_2 + Q_gen;

q_nadir = q_nadir_solar + q_nadir_albedo + q_nadir_IR;
A_MLI = A_zenit_MLI + A_antisun + A_sun + A_ram_MLI;
A_rad = (Q_in + q_nadir * alpha_MLI * A_nadir - sigma*T^4*eps_MLI*(A_nadir + A_MLI))/...
    (q_nadir*(alpha_MLI-alpha_rad)+sigma*T^4*(eps_rad-eps_MLI));

if A_rad<0
    A_rad = 0;
    Q_nadir = q_nadir * alpha_MLI * A_nadir;
    Q_in = Q_in+Q_nadir;
    T_balance = (Q_in/(sigma*(eps_MLI*(A_MLI+A_nadir)+eps_patch*A_patch+A_prop*eps_prop+eps_ant1*A_ant1+eps_ant2*A_ant2)))^(1/4)-273.15;
    fprintf("Radiator unnecessary: balance T = %g C\n",T_balance)
end
end