function az = azimuth(ENU)

for i = 1:length(ENU)
    R_e = ENU(i,1);
    R_n = ENU(i,2);
    R_u = ENU(i,3);

    az(i) = acosd(R_e/sqrt(R_e^2+R_n^2));

end

end
