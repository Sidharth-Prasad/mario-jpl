function [q_zenit_cold, q_nadir_solar_cold, q_nadir_albedo_cold, q_nadir_IR_cold, ...
    q_sun_solar_cold, q_sun_albedo_cold, q_sun_IR_cold, ...
    q_antisun_solar_cold, q_antisun_albedo_cold, q_antisun_IR_cold, ...
    q_ram_solar_cold, q_ram_albedo_cold, q_ram_IR_cold] = heat_cold(elevation)
%           beta = [0,      45,     70,  90] deg
q_zenit_500_cold = [418.2, 295.8, 143.1, 1.3];
q_zenit_700_cold = [418.2, 295.8, 143.1, 1.3];
q_zenit_cold = lineariz(elevation,500,700,q_zenit_500_cold,q_zenit_700_cold);
q_nadir_solar_500_cold = [41.3, 44.7, 143.1, 1.3];
q_nadir_solar_700_cold = [41.3, 62, 143.1, 1.3];
q_nadir_solar_cold = lineariz(elevation,500,700,q_nadir_solar_500_cold,q_nadir_solar_700_cold);
q_nadir_albedo_500_cold = [79.1, 66.3, 42.7, 15.2];
q_nadir_albedo_700_cold = [74.6, 62.6, 40.9, 18.8];
q_nadir_albedo_cold = lineariz(elevation,500,700,q_nadir_albedo_500_cold,q_nadir_albedo_700_cold);
q_nadir_IR_500_cold = [186.6, 186.8, 186.7, 186.5];
q_nadir_IR_700_cold = [176.4, 176.4, 176.3, 176.2];
q_nadir_IR_cold = lineariz(elevation,500,700,q_nadir_IR_500_cold,q_nadir_IR_700_cold);
q_sun_solar_500_cold = [0.8, 630.7, 1237.6, 1317];
q_sun_solar_700_cold = [0.9, 661, 1237.6, 1317];
q_sun_solar_cold = lineariz(elevation,500,700,q_sun_solar_500_cold,q_sun_solar_700_cold);
q_sun_albedo_500_cold = [24.5, 23.7, 19, 16.5];
q_sun_albedo_700_cold = [21.3, 21.4, 18.1, 18.2];
q_sun_albedo_cold = lineariz(elevation,500,700,q_sun_albedo_500_cold,q_sun_albedo_700_cold);
q_sun_IR_500_cold = [58.3, 58.1, 58.1, 58];
q_sun_IR_700_cold = [50.8, 50.6, 50.6, 50.6];
q_sun_IR_cold = lineariz(elevation,500,700,q_sun_IR_500_cold,q_sun_IR_700_cold);
q_antisun_solar_500_cold = [0.8, 0, 0, 0];
q_antisun_solar_700_cold = [0.8, 0, 0, 0];
q_antisun_solar_cold = lineariz(elevation,500,700,q_antisun_solar_500_cold,q_antisun_solar_700_cold);
q_antisun_albedo_500_cold = [24.5, 17.5, 8.3, 0];
q_antisun_albedo_700_cold = [21.3, 14.6, 6.3, 0];
q_antisun_albedo_cold = (q_antisun_albedo_500_cold + q_antisun_albedo_700_cold)/2;
q_antisun_IR_500_cold = [58.2, 58.2, 58.2, 58];
q_antisun_IR_700_cold = [50.7, 50.7, 50.7, 50.5];
q_antisun_IR_cold = lineariz(elevation,500,700,q_antisun_IR_500_cold,q_antisun_IR_700_cold);
q_ram_solar_500_cold = [287.3, 226, 143.1, 1.3];
q_ram_solar_700_cold = [299.7, 238.4, 143.1, 1.3];
q_ram_solar_cold = lineariz(elevation,500,700,q_ram_solar_500_cold,q_ram_solar_700_cold);
q_ram_albedo_500_cold = [24.6, 20.6, 13.3, 5.3];
q_ram_albedo_700_cold = [21.4, 18, 11.8, 5.8];
q_ram_albedo_cold = lineariz(elevation,500,700,q_ram_albedo_500_cold,q_ram_albedo_700_cold);
q_ram_IR_500_cold = [58, 57.9, 57.9, 57.9];
q_ram_IR_700_cold = [50.5, 50.5, 50.5, 50.5];
q_ram_IR_cold = lineariz(elevation,500,700,q_ram_IR_500_cold,q_ram_IR_700_cold);
end

function y = lineariz(x, x1, x2, y1, y2)
y = (x-x2)/(x1-x2)*(y1-y2)+y2;
end