function [w, b] = svm(x, y, sigma, lambda)

[n, dim] = size(x);

cvx_begin
    variables w(dim) b;
    minimize(lambda/2*(w'*w) + 1/n*sum(max(0, 1-y.*(x*w+b))));
cvx_end

end