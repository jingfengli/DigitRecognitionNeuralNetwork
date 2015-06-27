function H  = Dx(Vx)
    global a;
    global b;
    H = a* tanh(b* Vx);


    %a = 0.4;
    %H = 1 ./(1+exp(-a * Vx));

    %a = 0.4;
    %H = a * Vx;
end