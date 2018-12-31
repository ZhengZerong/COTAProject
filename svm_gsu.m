function [w, b] = svm_gsu(x, y, sigma, lambda)
% INPUT
%  x:       num-by-dim matrix. num is the number of data points,
%           dim is the dimension of a point. 
%  y:       num-by-1 vector, specifying the class that each point 
%           belongs to. 
%           either be +1 or -1
%  sigma:   num-by-dim matrix, specifying the measurement variance
%           (uncertainty) of each value in x
%  lambda:  a scalar specifying the weight of regularization term
% OUTPUT
%  w:   dim-by-1 vector, the normal direction of hyperplane
%  b:   a scalar, the bias

[n, dim] = size(x);
 
% define loss
d_x = @(w, b) 1 - y.*(x*w+b);
d_sigma = @(w, b) sqrt(2*sigma*(w.*w));
L1 = @(w, b) 0.5*d_x(w, b).*(erf(d_x(w, b)./d_sigma(w, b))+1);
L2 = @(w, b) (1/(2*sqrt(pi)))*d_sigma(w, b).*exp(-(d_x(w, b).^2)./(d_sigma(w, b).^2));
L  = @(w, b) L1(w, b) + L2(w, b);
J  = @(wb) lambda/2*wb(1:end-1)'*wb(1:end-1) + sum(L(wb(1:end-1), wb(end)))/n;

% specify the initial value randomly
% Since J is convex, the initial value has no impact on the optimal results
w = randn(dim, 1);
b = 100;  
wb0 = [w;b];

% solve the optimization problem
options = optimoptions('fminunc'); 
options.Display = 'iter';
options.StepTolerance = 0.0001;
wb_opt = fminunc(J, wb0, options);
w = wb_opt(1:end-1);
b = wb_opt(end);

end

% function value = J_func(w, b, x, y, sigma, lambda)
% value = 0.5*lambda*(w'*w);
% [n, ~] = size(x);
% for i = 1:n
%     xi = x(i, :)';
%     yi = y(i);
%     sigmai = diag(sigma(i, :));
%     
%     d_x = 1-yi*(w'*xi+b);
%     d_sigma = sqrt(2*w'*sigmai*w);
%     r = d_x/d_sigma;
%     L = 0.5*d_x*(erf(r) + 1) + (1/(2*sqrt(pi)))*d_sigma*exp(-r*r);
%     value = value + L/n;
% end
% end
