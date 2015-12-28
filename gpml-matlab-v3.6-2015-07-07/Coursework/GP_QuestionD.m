  x = linspace(-5,5,100)';   
  meanfunc = {@meanSum, {@meanLinear, @meanConst}}; 
  covfunc = {@covProd, {@covPeriodic, @covSEiso}}; 
  

 hyp.cov = [-0.5, 0, 0, 0.0001, 0];  
 

 %hyp.mean = [1; 5];
  
 % mu = feval(meanfunc{:}, hyp.mean, x);
  n=100;
  K =  feval(covfunc{:}, hyp.cov, x);
  K_I = K + 1e-6*eye(100);  %adding a small diagonal matrix
  y = chol(K)'*gpml_randn(0.15, n, 1)% + mu;
  
%  y = chol(K)'*gpml_randn(0.15, n, 1);
  
  plot(x, y, '+-')
  
  %y = chol(K)'*gpml_randn(0.15, n, 1)

%   
%   hyp.lik = log(0.9);
%   %hyp.lik = log(0.9), log(0.1), 0, 5, 2 ;
%   likfunc = @likGauss;   
% 
%   hyp = minimize(hyp, @gp, -100, @infExact, meanfunc, covfunc, likfunc, x, y);  
%   exp(hyp.lik)
%    
%   nlml = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y);  
%   
%     
%   figure(1)
%   plot(x,y, '+')
%   xlabel('x values')
%   ylabel('y values')
%   title('Data Generated from a Gaussian Process')
% 
%   
%   z = linspace(-5, 5, 101)';
%   
%   [m s1] = gp(hyp, @infExact, meanfunc, covfunc, likfunc, x, y, z);
%   f = [m+2*sqrt(s1); flipdim(m-2*sqrt(s1),1)];
%   fill([z; flipdim(z,1)], f, [7 7 7]/8)
%   figure(1)
%   hold on; plot(z, m); plot(x, y, '+')
%   ylabel('output, y')
%   xlabel('input, x')
%   title('Predictive Distribution using a Gaussian Process')
%   legend('GP with Squared Exponential Covariance Function')
%   
  