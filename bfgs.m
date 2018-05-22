function [x, val, k] = bfgs(setting, arg, input)

maxk = 500; stop_step = 8;
epsilon = 1e-5;
best_f = 1e10;
rho = 0.55; sigma = 0.4;
N = setting.m * (setting.N - 1);
k = 0;

x0 = input;
x = x0;
fit = evalFitness(setting, arg, x0);
val = fit;
% Bk = getHessian(setting, arg, x0,fit) + 1e-6*eye(N);
Bk = eye(N);
bad = 0;
while(k<maxk && bad<stop_step)
    fit = evalFitness(setting, arg, x0);
    gk = getGradient(setting, arg, x0,fit);
    if (norm(gk) < epsilon)
        break
    end
    dk = -Bk\gk;
    m=0;mk=0;
    % fprintf('gk^T*dk = %2.3f ',gk'*dk);
    while(m<80) % m should be large enough!
        newf = evalFitness(setting, arg, x0+rho^m*dk);
        if(newf < (fit+sigma*rho^m*gk'*dk))
            mk = m;break;
        end
        m = m+1;
        if (m>20)
            x = input;
            return;
        end
    end
    % fprintf('mk = %d\n', mk);
    x = x0 +rho^mk*dk;
    sk = rho^mk*dk;
    fit = evalFitness(setting, arg, x);
    yk = getGradient(setting,arg,x,fit) - gk;
    
    if(yk'*sk >0)
        Bk = Bk -(Bk*sk*sk'*Bk)/(sk'*Bk*sk)+(yk*yk')/(yk'*sk);
    end
    k = k+1;
    x0 = x;
    if(fit<(best_f- epsilon))
        best_f = fit;
        bad = 0;
    else
        bad = bad + 1;
    end
end
val = fit;
end