function T  = Dh(Vh)
    global a;
    global b;

    T = a* tanh(b* Vh);
    %T = 1 ./(1+exp(-a*Vh)); 
    %a = 0.3;
    %T = a * Vh;
end