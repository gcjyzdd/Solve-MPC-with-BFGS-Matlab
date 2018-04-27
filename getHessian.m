function hess = getHessian(setting, arg,input,fit)

d = 1e-9;
N = setting.m * (setting.N - 1);

hess = zeros(N,N);

h12 = 0; h1 = 0; h2 = 0;
for i=1:N
    for j=1:i
        input(i) = input(i) + d;
        h1 = evalFitness(setting, arg,input);
        input(j) = input(j) + d;
        h12 = evalFitness(setting, arg,input);
        input(i) = input(i) - d;
        h2 = evalFitness(setting, arg,input);
        input(j) = input(j) - d;
        
        hess(i,j) = (h12 - h1 - h2 + fit)/d/d;
        hess(j,i) = hess(i,j);
    end
end

end