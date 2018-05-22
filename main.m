
clear;close all;

setting.Lf = 1.17;
setting.dt = 0.05;
setting.N = 25;
setting.m = 2;
setting.n = 6;

arg.ref_v = 40;
arg.coeffs = [-1 0 0];
arg.x = -1;
arg.y = 10;
arg.psi = 0;
arg.v = 10;
arg.cte = -11;
arg.epsi = 0;

iters = 50;

input = zeros(setting.m * (setting.N-1),1);
%input = [-0.436332, -0.436332, -0.436332, -0.436332, -0.436332, -0.436332, -0.436332, -0.361205, -0.084008, 0.00921875, 0.0251219, 0.0273703, 0.0318472, 0.0410912, 0.058353, 0.0920002, 0.155297, 0.257393, 0.379378, 0.436332, 0.436332, 0.436332, 0.41456, 0.231595, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]';
f1 = evalFitness(setting, arg,input);

grad = getGradient(setting,arg,input,f1);
hess = getHessian(setting,arg,input,f1);
% rank(hess)
Data = zeros(6,iters);
INPUT = zeros(2, iters);
tic
for i=1:iters
    [x, val, step] = bfgs_mex(setting, arg, input);
    % [x, val, step] = bfgs(setting, arg, input);
    % fprintf('i = %d, val = %4.3f,\tstep = %d\n', i,val,step)
    states = getStates(setting, arg, x);
    arg.x = states(1,2);
    arg.y = states(2,2);
    arg.psi = states(3,2);
    arg.v = states(4,2);
    arg.cte = states(5,2);
    arg.epsi = states(6,2);
    
    Data(:,i) = states(:,2);
    INPUT(:,i) = [x(1); x(setting.N)];
    input = x ;%+ 1e-3*rand;
end
elapsedTime = toc;
fprintf('Average time consumption is: %1.3f\n', elapsedTime/iters);

states = getStates(setting, arg, x);

figure

subplot(511)
plot(Data(1,:), Data(2,:), '*-')
title('Trajectory')
xlabel('x [m]')
ylabel('y [m]')

subplot(512)
plot(Data(5,:))
ylim([-0.3 0.3])
xlim([0 50])
title('CTE')

subplot(513)
plot(Data(4,:))
xlim([0 50])
title('Velocity')

subplot(514)
plot(INPUT(1,:))
xlim([0 50])
title('Steer')
subplot(515)
plot(INPUT(2,:))
xlim([0 50])
title('Acceleration')