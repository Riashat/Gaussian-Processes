 load('cw1e.mat')
 %mesh(reshape(x(:,1), 11, 11), reshape(x(:,2),11,11), reshape(y,11,11)); 
 
 Xtest = linspace(-10, 10, 100);
 Ytest = linspace(-10, 10, 100);
 
 [L1,L2]=meshgrid(Xtest',Ytest');
 
 z =  [L1(:),L2(:)];
 
 X1 = reshape(x(:,1), 11, 11);
 X2 = reshape(x(:,2),11,11);
 Y = reshape(y,11,11);
 figure(1)

 surf(X1, X2, Y)

 
 covfunc = @covSEiso; 
 hyp.cov = [0.2 0.2];
 
 hyp.lik = log(0.1);
 likfunc = @likGauss;
 
 hyp = minimize(hyp, @gp, -100, @infExact, [], covfunc, likfunc, x, y);  
 exp(hyp.lik)  
 
 nlml = gp(hyp, @infExact, [], covfunc, likfunc, x, y); 
  
%[m s1] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, z);
 
[ymu ys2 fmu fs2] = gp(hyp, @infExact, [], covfunc, likfunc, x, y, z);
[mu,~]=meshgrid(ymu,ymu);

figure(2)
surf(L1,L2,reshape(ymu+2*sqrt(ys2),size(L1)));
hold on;
surf(L1,L2,reshape(ymu-2*sqrt(ys2),size(L1)));


  


 
