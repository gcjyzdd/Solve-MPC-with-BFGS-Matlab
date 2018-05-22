% BFGS_SCRIPT   Generate MEX-function bfgs_mex from bfgs.
% 
% Script generated from project 'bfgs.prj' on 22-May-2018.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.

%% Create configuration object of class 'coder.MexCodeConfig'.
cfg = coder.config('mex');
cfg.GenerateReport = true;

%% Define argument types for entry-point 'bfgs'.
ARGS = cell(1,1);
ARGS{1} = cell(3,1);
ARGS{1}{1} = struct;
ARGS{1}{1}.Lf = coder.typeof(0);
ARGS{1}{1}.dt = coder.typeof(0);
ARGS{1}{1}.N = coder.typeof(0);
ARGS{1}{1}.m = coder.typeof(0);
ARGS{1}{1}.n = coder.typeof(0);
ARGS{1}{1} = coder.typeof(ARGS{1}{1});
ARGS{1}{2} = struct;
ARGS{1}{2}.ref_v = coder.typeof(0);
ARGS{1}{2}.coeffs = coder.typeof(0,[1 3]);
ARGS{1}{2}.x = coder.typeof(0);
ARGS{1}{2}.y = coder.typeof(0);
ARGS{1}{2}.psi = coder.typeof(0);
ARGS{1}{2}.v = coder.typeof(0);
ARGS{1}{2}.cte = coder.typeof(0);
ARGS{1}{2}.epsi = coder.typeof(0);
ARGS{1}{2} = coder.typeof(ARGS{1}{2});
ARGS{1}{3} = coder.typeof(0,[48  1]);

%% Invoke MATLAB Coder.
codegen -config cfg bfgs -args ARGS{1}
