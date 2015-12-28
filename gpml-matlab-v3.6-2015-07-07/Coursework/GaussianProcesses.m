clear all, close all

%STEP WISE STEPS OF THE DEMO
 %This is a simple example, where we first generate n=20 data points from a GP, 
 %where the inputs are scalar (so that it is easy to plot what is going on).
 %We then use various other GPs to make inferences about the underlying function. 
  meanfunc = {@meanSum, {@meanLinear, @meanConst}}; hyp.mean = [0.5; 1];
  covfunc = {@covMaterniso, 3}; ell = 1/4; sf = 1; hyp.cov = log([ell; sf]);
  likfunc = @likGauss; sn = 0.1; hyp.lik = log(sn);
 
  n = 20;
  x = gpml_randn(0.3, n, 1);    % x is 20x1 data
  K = feval(covfunc{:}, hyp.cov, x);
  mu = feval(meanfunc{:}, hyp.mean, x);
  y = chol(K)'*gpml_randn(0.15, n, 1) + mu + exp(hyp.lik)*gpml_randn(0.2, n, 1);    % y is 20x1
  plot(x, y, '+')
  
  %The mean function is composite, adding (using meanSum function) a linear (meanLinear) 
  %and a constant (meanConst) to get an affine function.
  
  %The hyperparameters for the mean are given in hyp.mean and consists of a single (because the input will one dimensional, i.e. D=1) 
  %slope (set to 0.5) and an off-set (set to 1). 
  %The number and the order of these hyperparameters conform to the mean function specification.
  
  % COVARIANCE FUNCTION OF COVMATERNISO FORM 
  % LIKELIHOOD FUNCTION SPECIFIED AS GAUSSIAN 
  
  nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y);

  %other test inputs z
  z = linspace(-1.9, 1.9, 101)';
  [m s2] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);

  f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)]; 
  fill([z; flipdim(z,1)], f, [7 7 7]/8)
  hold on; plot(z, m); plot(x, y, '+')
   
  
  z = linspace(-1.9, 1.9, 101)';
  covfunc = @covSEiso; hyp2.cov = [0; 0]; hyp2.lik = log(0.1);
  hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, x, y);
  exp(hyp2.lik)
  nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x, y)
  
  [m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x, y, z);
  f = [m+2*sqrt(s2); flipdim(m-2*sqrt(s2),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8)
  
  hold on; plot(z, m); plot(x, y, '+')
  
  
  
  
  
  
  
  
  
  
 