semimajor_axis = input("semimajor_axis(km) =");
eccentricity = input("eccentricity =");
true_anomaly = input("true_anomaly(deg) =");

rangInPQW = solveRangInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)


function rangInPQW = solveRangInPerifocalFrame(semimajor_axis, eccentricity, true_anomaly)

a = semimajor_axis;
e = eccentricity;
v = true_anomaly;

p = a*(1-e^2);  %semi-latus rectum
r = p/(1+e*cosd(v));

rangInPQW = [r*cosd(v); r*sind(v); 0];

end