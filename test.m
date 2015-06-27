function [Err,Sum] = test(Wx, Wh)
    load mnist_all;
    global a;
    global b;

    a = 1;
    b = 0.01;
    Err = zeros(1,10);
    Sum = zeros(1,10);

    for Ch = 0:9
        nT = 1;
        Red=sprintf('XX = double(test%d);',Ch);
        eval(Red);
        Sum(Ch+1) = length(XX);
        while nT <= length(XX)
            X  = XX(nT,:);
            Vx = [X, 1] * Wx;H  = Dx(Vx);
            Vh = [H, 1] * Wh;T = Dh(Vh);
            [Vav, Prd] = max(T);
            if Prd-1 ~= Ch
                Err(Ch+1) = Err(Ch+1) +1;
            end
            nT = nT +1;
        end
    end
end
