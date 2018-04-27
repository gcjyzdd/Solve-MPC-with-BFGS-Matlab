function states = getStates(setting, arg, input)

state0 = zeros(6, 1);
state1 = zeros(6, 1);

state0(1) = arg.x;
state0(2) = arg.y;
state0(3) = arg.psi;
state0(4) = arg.v;
state0(5) = arg.cte;
state0(6) = arg.epsi;

Lf = setting.Lf;
dt = setting.dt;

N = setting.N;

states = zeros(6, N);
states(:,1) = state0;

for i = 1:(N-1)
    state1(1) = state0(1) + state0(4) * cos(state0(3)) * dt;
    state1(2) = state0(2) + state0(4) * sin(state0(3)) * dt;
    state1(3) = state0(3) + state0(4) * input(i) / Lf * dt;
    state1(4) = state0(4) + input(N-1+i) * dt;
    state1(5) = polyVal(arg.coeffs, state0(1)) - state0(2) + state0(4)*sin(state0(6))*dt;
    state1(6) = state0(3) - atan(arg.coeffs(2)+2*arg.coeffs(3)) + state0(4)*input(i)/Lf*dt;
    
    state0(1) = state1(1);
    state0(2) = state1(2);
    state0(3) = state1(3);
    state0(4) = state1(4);
    state0(5) = state1(5);
    state0(6) = state1(6);
   
    states(:,i+1) = state0;
end

end

function y = polyVal(coeffs,x)
    y = coeffs(1) +coeffs(2)*x +coeffs(3)*x*x;
end