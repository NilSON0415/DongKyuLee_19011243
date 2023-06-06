year = input("Year =");
month = input("Month =");
day = input("Day = ");
hour = input("Hour = ");
minute = input("Min = ");
sec = input("Sec = ");

time = datetime(year,month,day,hour,minute,sec);

DCM = ECI2ECEF_DCM(time)

function DCM = ECI2ECEF_DCM(time)

DCM = dcmeci2ecef('IAU-2000/2006',time);

end


