 load('cw1e.mat')
 figure(1)
 mesh(reshape(x(:,1), 11, 11), reshape(x(:,2),11,11), reshape(y,11,11));
   
 covfunc = @covSEiso; hyp.cov = [-1;0]; hyp.lik = 0;
 likfunc = @likGauss;
 hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, x, y);  
 exp(hyp.lik)
 nlml = gp(hyp, @infExact, [], covfunc, likfunc, x, y);  
 
 
  z = x(100:121, :);
  
  [m s1] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, z);
  f = [m+2*sqrt(s1); flipdim(m-2*sqrt(s1),1)];
  fill([z; flipdim(z,1)], f, [7 7 7]/8)
  figure(1)
  hold on; plot(z, m); plot(x, y, '+')
  ylabel('output, y')
  xlabel('input, x')
  title('Predictive Distribution using a Gaussian Process')
  legend('GP with Squared Exponential Covariance Function')
  
  