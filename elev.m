function el = elevation(ENU, el_mask)

for i = 1:length(ENU)
    R_e = ENU(i,1);
    R_n = ENU(i,2);
    R_u = ENU(i,3);
    R_rel = [R_e;R_n;R_u];
    R_rel_ab = mean(R_rel);

    el(i) = asind(R_u/R_rel_ab);
    if el(i) <= el_mask
        el(i) = NaN;
    end
end