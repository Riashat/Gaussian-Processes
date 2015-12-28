clear all
clc
load('mauna.mat')
x = trainyear;      y = trainCO2;
x_test = testyear;  y_test = testCO2;

k1 = {@covProd, {@covLIN, @covSEiso}}; 
k2 = {@covProd, {@covSEiso, @covPeriodic}}; 
k3 = {@covProd, {@covSEiso, @covRQiso}}; 

covfunc = {@covSum, {k1, k2, k3}};
 hyp1.cov = [0.5; 0.5; 0.5; 0.5; 0.1; 0.1; 0.1; 0.5; 0.5; 0.1; 0.1; 0.1];
 hyp1.lik = 0; 

 
likfunc = @likGauss; 
 hyp1 = minimize(hyp1, @gp, -100, @infExact, [], covfunc, likfunc, x, y);  
 exp(hyp1.lik)  
 
 nlml = gp(hyp1, @infExact, [], covfunc, likfunc, x, y); 
 
 [m1 s1] = gp(hyp1, @infExact, [], covfunc, likfunc, x, y, x_test);
 

  
  
  f = [m1+2*sqrt(s1); flipdim(m1-2*sqrt(s1),1)];
  fill([x_test; flipdim(x_test,1)], f, [7 7 7]/8)
  figure(1)
  hold on; plot(x_test, m1); plot(x, y, '+')
  ylabel('output, y')
  xlabel('input, x')
  title('Predictive Distribution using a Gaussian Process with Kernels LINxSE + SExPER + SExRQ')
  legend('GP with LINxSE + SExPER + SExRQ')
  