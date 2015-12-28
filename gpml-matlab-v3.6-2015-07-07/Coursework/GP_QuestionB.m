  clear all
  clc
  load('cw1d.mat')% x is 75x1     % y is 75x1

  %splitting data into training and test points
  %training the GP with 75% of the data

  c_l = [-10, -2, -1, 0, 0.5, 1, 3, 10];
  c_sf = [ 0, 0.5, 1, 2, 10, -10, -2, -1];

  
  
  plot(x,y, '+')

  %QUESTION B
  
  covfunc = @covSEiso; hyp.cov = [c_l(i); c_l(j)]; hyp.lik = 10;
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
  legend('GP with Squared Exponential Covariance Function')
  
  s = meshgrid(0.1:0.05:10,0.1:0.05:10);
  hyp.cov = [log(s(i,j));0]
  nlmt(:) = 
  

 
  
  