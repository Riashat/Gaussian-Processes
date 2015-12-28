  x = linspace(-5,5,100)';   

  covfunc = {@covProd, {@covPeriodic, @covSEiso}}; 
  
  hyp.cov = [-0.5, 0, 0, 2, 0];   

  n=100;
  K =  feval(covfunc{:}, hyp.cov, x);
  K_I = K + 1e-6*eye(100);  %adding a small diagonal matrix
  y = chol(K)'* gpml_randn(0.15, n, 1);
  
  %y = chol(K)'*gpml_randn(0.15, n, 1)
  
  figure(1)
  plot(x,y, '+')
  xlabel('x values')
  ylabel('y values')
  title('Data Generated from a Gaussian Process')


  
  hyp.lik = 0;

  likfunc = @likGauss;   

  hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, x, y);  
  exp(hyp.lik)
   
  nlml = gp(hyp, @infExact, [], covfunc, likfunc, x, y);  
  
  z = linspace(-5, 5, 101)';
  
  [m s1] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, z);
  f = [m+2*sqrt(s1); flipdim(m-2*sqrt(s1),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8)
  figure(1)
  hold on; plot(z, m); plot(x, y, '+')
  ylabel('output, y')
  xlabel('input, x')
  title('Predictive Distribution using a Gaussian Process')
  legend('GP with Squared Exponential Covariance Function')
  
  
  %ADD A SMALL DIAGONAL MATRIX. WHY?
  
  % K MUST BE POSITIVE DEFINITE?
  % K MUST BE A PSD MATRIX FOR IT TO BE A VALID COVARIANCE FUNCTION?
  
  
  
  % SAMPLE FUNCTIONS ACHIEVED BY 
  
  % changing the hyp.lik parameters
  % log(0.9), log(0.1), 0, 5, 2 
  
  
  % changing the hyp.cov parameters
   % hyp.cov = [0.5, 0.5, 0.5, 0.5, 0.5];
 %  hyp.cov = [-2, 0, 0, 2, 0];  
  %  hyp.cov = [-0.5, 0.5, 0, 2, 0]; 
  %hyp.cov = [-0.5, 0, 0, 2, 0.5];
  
% changing the z values
  % z = linspace(-5, 5, 101)';
  
  