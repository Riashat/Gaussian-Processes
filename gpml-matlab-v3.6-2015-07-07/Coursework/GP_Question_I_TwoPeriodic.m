load('mauna.mat')
x = trainyear;      y = trainCO2;
x_test = testyear;  y_test = testCO2;
 
 
 hyp.cov = [0.5; 0.5; 0.5; 0; 0; 0];
 
 hyp.lik = log(0.1);
 
covfunc = {@covSum, {@covPeriodic, @covPeriodic}};
likfunc = @likGauss; 

 hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, x, y);  
 exp(hyp.lik)  
 
 nlml = gp(hyp, @infExact, [], covfunc, likfunc, x, y); 
 
 [m s1] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, x_test);
  
  f = [m+2*sqrt(s1); flipdim(m-2*sqrt(s1),1)];
  fill([x_test; flipdim(x_test,1)], f, [7 7 7]/8)
  figure(1)
  hold on; plot(x_test, m); plot(x, y, '+')
  ylabel('output, y')
  xlabel('input, x')
  title('Predictive Distribution using a Gaussian Process')
  legend('GP with Squared Exponential Covariance Function')
  