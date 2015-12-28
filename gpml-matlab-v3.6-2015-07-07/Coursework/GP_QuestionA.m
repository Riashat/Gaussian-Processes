  clear all
  clc
  load('cw1d.mat')% x is 75x1     % y is 75x1
  
  %splitting data into training and test points
  %training the GP with 75% of the data

  plot(x,y, '+')

  %QUESTION A
  covfunc = @covSEiso; hyp.cov = [-1; 0]; hyp.lik = 0;
  likfunc = @likGauss;
  hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, x, y);
  exp(hyp.lik)

  nlml = gp(hyp, @infExact, [], covfunc, likfunc, x, y);
  
  z = linspace(-3, 3, 101)';
  
  [m s1] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, z);
  f = [m+2*sqrt(s1); flipdim(m-2*sqrt(s1),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8);

  hold on; plot(z, m); plot(x, y, '+')
  ylabel('output, y')
  xlabel('input, x')
  title('Predictive Distribution using a Gaussian Process')
  legend('GP with Squared Exponential Covariance Function, hyp.cov = [-1, 0] ')
  


  % EXPLANATIONS:
 
  % the error bars show that with further from most of the data
  % the predictive distribution is quite uncertain about the possible
  % function, hence large regions of uncertainty
  
  % in regions with lots of data points, even though the error bars show
  % reasonable confidence (less uncertainty), neverthless, at exactly the
  % data points, the GP is still uncertain (with higher confidence though).
  
  
  %the variance of the SQE is 0
  % lengthscale = -1
  
  %AFTER OPTIMIZING HYPERPARAMETERS
  %the length scale is further reduced (TOO LOW)
  % the variance is further decreased
  % but the marginal likelihood is not favouring this!
  
  % too much fit of the data in regions of high data points
  % so marginal likelihood is low - automatically incorporating a trade-off
  % between model fit and complexity
  
  