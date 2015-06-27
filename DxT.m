function HT = DxT(Vx)
    global a;
    global b;
    HT = b/a*(a - Dx(Vx)) .* (a + Dx(Vx));
 

    %a = 0.04;
     %HT = Dx(Vx).* ( 1 - Dx(Vx));
    %a = 0.4;
    %HT = a * ones(1,length(Vx));
end