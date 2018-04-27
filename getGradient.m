function grad = getGradient(setting,arg,input,fit)

d = 1e-6;
N = setting.m * (setting.N - 1);

grad = zeros(N,1);

for i=1:N
    input(i) = input(i) + d;
    grad(i) = (evalFitness(setting,arg,input) - fit)/d;
    input(i) = input(i) - d;
end

end
