semimajor_axis = input("semimajor_axis(km) =");
eccentricity = input("eccentricity =");
true_anomaly = input("true_anomaly(deg) =");

velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis,eccentricity,true_anomaly)

function velocityInPQW = solveVelocityInPerifocalFrame(semimajor_axis,eccentricity,true_anomaly)

a = semimajor_axis;
e = eccentricity;
v = true_anomaly;
u = 3.986004418*10^5; %(km^3/s^2)

p = a*(1-e^2);  %semi-latus rectum

velocityInPQW = sqrt(u/p)*[-sind(v); e+cosd(v); 0];

end
