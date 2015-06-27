function MidTerm2_final
%1.	Initialize weight matrix Wx and Wh. (n X m).
%2.	Go through each input, Calculate Vx, H, Vh and T.
%   2a.	Vx = [X,X0] * Wx
%   2b.	H  = Dx(Vx)
%   2c.	Vh = [H, H0] * Wh
%   2d.	T = Dh(H)
%3.	Update Wh and calculate Error of hidden layer
%   3a.	For weight vector for each output, which correspond one column of Wh
%   Update rule:
%   Et = dT  T;
%   ?h = Et * Dh;
%   Wh(n+1) = Wh(n) + ?h * ?h * H;
%   3b.	Calculate Error of hidden layer
%       3b.i.	Assign Error of each output element to hidden layer based on the Weight.
%           Eh = Et * Dh * Wh;
%       3b.ii.	Sum of Error from each output element is the Error of hidden layer
%4.	Update Wx
%   4a.	For weight vector for each hidden element, which is one column of Wx
%   Update rule:
%   ?x = Eh * Dx;
%   Wx(n+1) =Wx(n) + ?x * ?x * X;
%5.	Repeat (2) to (4), until Et = 0 or n = 100;
clear all;
load mnist_all.mat;
global a;
global b;
imagesc(reshape(train0(1,:),28,28));
%load FirstSucces;

a = 1;
b = 0.01;
%1.	Initialize weight matrix Wx and Wh. (n X m).
Crit = 5e-1;
X = zeros(1,784);
Wx = random('unif',0,0.001,785,100);
Vx = zeros(1,40);
H = zeros(1,40);
Wh = random('unif',0,0.001,101,10);
Vh = zeros(1,40);

T =zeros(1,10);

ErE = zeros(7,10);
Sum = zeros(1,10);

itah = 0.1;
itax = 0.1;

Nu = ones(1,10);

Ei = 1;
[ErE(Ei,:),Sum] = test(Wx, Wh);
Ei = Ei +1;

for nn = 1 : 100000
    %2.	Go through each input, Calculate Vx, H, Vh and T.
    n = nn;
    if nn> 50000
        n = nn - 50000;
    end
    nd = ceil(n/10);
    md = n - 10* nd + 9;
    
    train = eval(sprintf('train%d',md));
    
    dT = zeros(1,10);
    dT(md + 1) = 1;
    
    while (1)
        %     Nu(Cc) = Nu(Cc) +1;
        X = double(train(nd,:));
        X0 = 1;
        Vx = [X, X0] * Wx;
        
        %   2b.	H  = Dx(Vx)
        H  = Dx(Vx);
        H0 = 1;
        Vh = [H, H0] * Wh;
        
        %   2d.	T = Dh(Vh)
        T =Dh(Vh);
        %3.	Update Wh and calculate Error of hidden layer
        %   3a.	For weight vector for each output, which correspond one
        %   column of Wh
        %   Update rule:
        %   Et = dT  T;
        Et = T;
        Et= dT - Et;
        
        if Et*Et' <= Crit
            break;
        end
        
        Deltah = Et .* DhT(Vh);
        
        Eh = Deltah * Wh';
        Eh = Eh(:,1 : end-1);
        
        Wh = Wh + itah * [H, H0]' * Deltah;
        
        %4.	Update Wx
        Deltax = Eh .* DxT(Vx);
        
        Wx = Wx + itax * [X,X0]' * Deltax;
        
        
        
        %5.	Repeat (2) to (4), until Et = 0 or n = 100;
        
    end
    
    if  nn == 10 || nn == 100 || nn == 1000 || nn == 10000 || nn == 50000 || nn == 100000
        [ErE(Ei,:),Sum] = test(Wx, Wh);
        Ei = Ei +1;
    end
end

figure; hold on;
Iter = [0 1 2 3 3+log10(5) 4];
ErI = sum(ErE,2) / sum(Sum);
plot(Iter,ErI(2:end),'r--','LineWidth',2,'MarkerSize',10);
xlabel('# of iteration, (log scale)');
ylabel('Prediction  Error');
legend('Prediction Error VS Training Iteration');
axis([0 4 0 1]);

ItS = {'0 iteration' '1e0 iteration' '1e1 iteration' '1e2 iteration' '1e3 iteration' '5e3 iteration' '1e4 iteration'};
X = zeros(7,10);
ErF = zeros(7,10);
for Fn = 1:7
    X(Fn,:) = 0:9;
    ErF(Fn,:) = 1 - ErE(Fn,:) ./ Sum;
end

figure;
plot(X',ErF','.--');
axis([-.5 9.5 0 1.2]);
xlabel('Each Digit');
ylabel('Successful classification');
legend(ItS);

figure;
bar(X(1,:),ErF(7,:));
axis([-1 10 0 1.2]);
xlabel('Each Digit');
ylabel('Successful classification');
legend('After 1e4 iteration');

figure;
plot(Iter,ErI(1:end-1) - ErI(2:end) ,'r--','LineWidth',2,'MarkerSize',10);
axis([0 4 0 .5]);
xlabel('Increase of Iteration (log scale)');
ylabel('Increase of Classification rate');
end
