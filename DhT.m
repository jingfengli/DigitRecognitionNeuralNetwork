function TT = DhT(Vh)
    global a;
    global b;
    TT = b/a*(a - Dh(Vh)) .* (a + Dh(Vh));
    %TT = Dh(Vh).* ( 1 - Dh(Vh));
    %a = 0.3;
    %TT = a * ones(1,length(Vh));
end