arg_prg = input("argument of perigee = ");
inc_angle = input("inclination angle = ");
RAAN = input("Right Ascension of Ascending Node = ");

Rot_Mat = PQW2ECI(arg_prg,inc_angle,RAAN)

function Rot_Mat = PQW2ECI(arg_prg,inc_angle,RAAN)

R1 = [cosd(RAAN) sind(RAAN) 0;
      -sind(RAAN) cosd(RAAN) 0;
      0 0 1];
R2 = [1 0 0;
      0 cosd(inc_angle) sind(inc_angle);
      0 -sind(inc_angle) cosd(inc_angle)];
R3 = [cosd(arg_prg) sind(arg_prg) 0;
      -sind(arg_prg) cosd(arg_prg) 0;
      0 0 1];

Rot_Mat = R1*R2*R3;

end
