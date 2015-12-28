  clear all
  clc
  load('cw1d.mat')% x is 75x1     % y is 75x1
  plot(x,y, '+')
  
  covfunc = @covPeriodic;
  ell = 2;    np = 5;       sf = 2;   
  hyp.cov = log([ell; np; sf]); 
  hyp.lik = log(0.1);

  likfunc = @likGauss;
  
  hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, x, y);  
  exp(hyp.lik)
  
  nlml = gp(hyp, @infExact, [], covfunc, likfunc, x, y);  
  
  z = linspace(-3, 3, 101)';
  
  
  
  [m s1] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, z);
  f = [m+2*sqrt(s1); flipdim(m-2*sqrt(s1),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8)
  figure(1)
  hold on; plot(z, m); plot(x, y, '+')
  ylabel('output, y')
  xlabel('input, x')
  title('Predictive Distribution using a Gaussian Process')
  legend('GP with Periodic Covariance')
  
  
  
  
  %EXPLANATION
  
  % Very low error bars and too much fit of the underlying function
  %Data generating mechanism is indeed periodic
  
  % Compared to A, the marginal likelihood is very low
  % shows that too much overfit of the data
  %NLML not supporting this - the distribution fits the data in a PERIODIC
  %way which is not supported by the marginal likelihood
  
  
  