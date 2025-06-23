%% input:
% x: n by p design matrix
% y: response of length n
% constr: linear constraint, for compositional data, constr=ones(p,1)/sqrt(p); for no constraint, constr=zeros(p,1)
% level: level of confidence interval
% tol: tolerance level in the computation
% maxiter: the maximum number of iteration in solving the regularized estimator using coordinate descent method

T = readtable('/MATLAB Drive/simulated_data_only_abundant_linear_1.txt', 'Delimiter', '\t');
y = T{:, 1};      
x = T{:, 2:end}; 
constr = ones(100,1);

level = 0.95;
tol = 1e-8;
maxiter = 200;


%% get regularized estimator
method = 2; % using CVX
[res.bet_n res.int res.sigma res.lam0]=sslr(y, x, constr, tol, maxiter, method);

%% get confidence interval
% for faster computation, we suggest you use CVX when p>2*n
[res.bet_u res.CI_l res.CI_u res.M]=cvx_ci(y, x, constr, res.bet_n, res.int, res.sigma, res.lam0, level, tol); % using CVX

%% output
% bet_n: regularized estimator
% int: intercept
% sigma: estimated noise level
% bet_u: debiased estimator
% [CI_l, CI_u]: confidence interval

