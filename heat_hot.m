function [q_zenit_hot, q_nadir_solar_hot, q_nadir_albedo_hot, q_nadir_IR_hot, ...
    q_sun_solar_hot, q_sun_albedo_hot, q_sun_IR_hot, ...
    q_antisun_solar_hot, q_antisun_albedo_hot, q_antisun_IR_hot, ...
    q_ram_solar_hot, q_ram_albedo_hot, q_ram_IR_hot] = heat_hot(elevation)
%           beta = [0,      45,     70,  90] deg
q_zenit_500_hot = [450.6, 318.7, 154.2, 1.4];
q_zenit_700_hot = [450.6, 318.7, 154.2, 1.4];
q_zenit_hot = lineariz(elevation,500,700,q_zenit_500_hot,q_zenit_700_hot);
q_nadir_solar_500_hot = [32.7, 48.2, 154.2, 1.4];
q_nadir_solar_700_hot = [44.5, 66.8, 154.2, 1.4];
q_nadir_solar_hot = lineariz(elevation,500,700,q_nadir_solar_500_hot,q_nadir_solar_700_hot);
q_nadir_albedo_500_hot = [123.9, 98.9, 59.6, 19.7];
q_nadir_albedo_700_hot = [116.9, 93.5, 57, 24.4];
q_nadir_albedo_hot = lineariz(elevation,500,700,q_nadir_albedo_500_hot,q_nadir_albedo_700_hot);
q_nadir_IR_500_hot = [224.6, 224.7, 224.6, 224.4];
q_nadir_IR_700_hot = [212.2, 212.2, 212.1, 211.9];
q_nadir_IR_hot = lineariz(elevation,500,700,q_nadir_IR_500_hot,q_nadir_IR_700_hot);
q_sun_solar_500_hot = [0.9, 679.5, 1333.4, 1419];
q_sun_solar_700_hot = [0.9, 712.2, 1333.4, 1419];
q_sun_solar_hot = lineariz(elevation,500,700,q_sun_solar_500_hot,q_sun_solar_700_hot);
q_sun_albedo_500_hot = [38.4, 35.4, 26.5, 21.4];
q_sun_albedo_700_hot = [33.3, 31.9, 25.2, 23.6];
q_sun_albedo_hot = lineariz(elevation,500,700,q_sun_albedo_500_hot,q_sun_albedo_700_hot);
q_sun_IR_500_hot = [70.1, 69.9, 69.8, 69.8];
q_sun_IR_700_hot = [61.1, 60.9, 60.9, 60.8];
q_sun_IR_hot = lineariz(elevation,500,700,q_sun_IR_500_hot,q_sun_IR_700_hot);
q_antisun_solar_500_hot = [0.9, 0, 0, 0];
q_antisun_solar_700_hot = [0.9, 0, 0, 0];
q_antisun_solar_hot = lineariz(elevation,500,700,q_antisun_solar_500_hot,q_antisun_solar_700_hot);
q_antisun_albedo_500_hot = [38.5, 26.1, 11.5, 0];
q_antisun_albedo_700_hot = [33.4, 21.7, 8.7, 0];
q_antisun_albedo_hot = lineariz(elevation,500,700,q_antisun_albedo_500_hot,q_antisun_albedo_700_hot);
q_antisun_IR_500_hot = [70, 70, 70, 69.8];
q_antisun_IR_700_hot = [60.9, 61, 61, 60.8];
q_antisun_IR_hot = lineariz(elevation,500,700,q_antisun_IR_500_hot,q_antisun_IR_700_hot);
q_ram_solar_500_hot = [309.5, 243.5, 154.2, 1.4];
q_ram_solar_700_hot = [322.9, 256.9, 154.2, 1.4];
q_ram_solar_hot = lineariz(elevation,500,700,q_ram_solar_500_hot,q_ram_solar_700_hot);
q_ram_albedo_500_hot = [38.6, 30.8, 18.6, 6.8];
q_ram_albedo_700_hot = [33.5, 26.8, 16.4, 7.5];
q_ram_albedo_hot = lineariz(elevation,500,700,q_ram_albedo_500_hot,q_ram_albedo_700_hot);
q_ram_IR_500_hot = [69.7, 69.7, 69.7, 69.7];
q_ram_IR_700_hot = [60.7, 60.7, 60.7, 60.7];
q_ram_IR_hot = lineariz(elevation,500,700,q_ram_IR_500_hot,q_ram_IR_700_hot);
end

function y = lineariz(x, x1, x2, y1, y2)
y = (x-x2)/(x1-x2)*(y1-y2)+y2;
end