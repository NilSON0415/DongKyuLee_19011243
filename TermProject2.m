clear
clc

load nav.mat
a = nav.GPS.a;
e = nav.GPS.e;
i = nav.GPS.i;
o = nav.GPS.omega;
M0 = nav.GPS.M0;
toc = nav.GPS.toc;
O = nav.GPS.OMEGA;
v0 = 360 + rad2deg(M0);
t0 = datetime(toc);
u = 3.986004418*10^5;
p = a*(1-e^2);  %semi-latus rectum

%%
R1 = [cosd(O) sind(O) 0;
      -sind(O) cosd(O) 0;
      0 0 1];
R2 = [1 0 0;
      0 cosd(i) sind(i);
      0 -sind(i) cosd(i)];
R3 = [cosd(o) sind(o) 0;
      -sind(o) cosd(o) 0;
      0 0 1];

Rot_Mat = (R1*R2*R3)';

spheroid = referenceEllipsoid('GRS 80');

for i = 1:1439
    t(i) = t0 + i/1440;
    t_d(i) = t(i) - t0;
    [h,m,s] = hms(t_d(i));
    t_t = h*3600 + m*60 + s;
    M(i) = M0 + sqrt(u/a^3)*(t_t);
    if M(i) > 0
        v(i) = rad2deg(M(i));
    else
        v(i) = 360 + rad2deg(M(i));
    end
    r = p/(1+e*cosd(v(i)))*1000;
    r_PQW = [r.*cosd(v(i)); r.*sind(v(i)); 0];
    r_eci = Rot_Mat*r_PQW;
    dcm_ci2ef = dcmeci2ecef('IAU-2000/2006',t(i));
    r_ecef = dcm_ci2ef*r_eci;
    [lat(i),lon(i),h(i)] = ecef2geodetic(spheroid,r_ecef(1),r_ecef(2),r_ecef(3));
    lat_table(i) = lat(i);
    lon_table(i) = lon(i);
    h_table(i) = h(i);
    [x(i),y(i),z(i)] = ecef2enu(r_ecef(1),r_ecef(2),r_ecef(3),lat(1),lon(1),h(1),spheroid);
    ENU = [x' y' z'];    

end
for i = 1:length(ENU)
    R_e = ENU(i,1);
    R_n = ENU(i,2);
    R_u = ENU(i,3);
    R_rel = [R_e;R_n;R_u];
    R_rel_ab = sqrt(R_e^2+R_n^2+R_u^2);
    el_mask = 10;
    az(i) = rad2deg(acos(R_e/sqrt(R_e^2+R_n^2)));
    el(i) = rad2deg(asin(R_u/R_rel_ab));
    if el(i) <= el_mask
        el(i) = el_mask;
    end

end
geoplot(lat_table,lon_table);
figure
skyplot(az,el);
