%
% A toy example for SVM-GSU implemented in Matlab
%
% Author:   Zerong Zheng
% Date:     12/27/2018


clear;
% close all;

% generate training data
x_p = [1, 1; 2, 1.5; 3, 2; 4, 2.5];
sigma_p = [1, 1; 1, 4; 1, 9; 1, 16]/40;

x_n = [1, 4; 2, 4.5; 3, 5.0; 4, 5.5];
sigma_n = [1, 16; 1, 9; 1, 4; 1, 1]/40;

% x_p = [1, 1; 2, 1; 3, 1; 4, 1; 5, 1];
% sigma_p = [1, 1; 1, 4; 1, 9; 1, 16; 1, 25];
% 
% x_n = [1, 4; 2, 4; 3, 4; 4, 4; 5, 4];
% sigma_n = [1,25; 1, 16; 1, 9; 1, 4; 1, 1];

x = [x_p; x_n];
y1 = [ones([length(x_p), 1]); -ones([length(x_n), 1])];
sigma = [sigma_p; sigma_n];
lambda = 0.00001;

% sample x and y for standard SVM
sample_num = 1000;
x_p_sample = [];
x_n_sample = [];
for i = 1:size(x_p)
    gauss_sample = randn(sample_num, size(x_p, 2));    
    sample_trans = gauss_sample.*sqrt(sigma_p(i, :)) + x_p(i, :);
    x_p_sample = [x_p_sample; sample_trans];
end
for i = 1:size(x_n)
    gauss_sample = randn(sample_num, size(x_n, 2));    
    sample_trans = gauss_sample.*sqrt(sigma_n(i, :)) + x_n(i, :);
    x_n_sample = [x_n_sample; sample_trans];
end
x_sample = [x_p_sample; x_n_sample];
y_sample = [ones(size(x_p_sample, 1), 1); -ones(size(x_n_sample, 1), 1)];

% training SVM
[w0, b0] = svm(x, y1, sigma, lambda);
[w1, b1] = svm_gsu(x, y1, sigma, lambda);
[w2, b2] = svm(x_sample, y_sample, sigma, lambda);
% [w1, b1] = svm_gsu(x_sample, y_sample, 0.01*ones(size(x_sample)), lambda);

% draw
figure;
hold on; plot(x_p(:, 1), x_p(:, 2), 'ro', 'MarkerSize',10, 'LineWidth',2);
hold on; plot(x_n(:, 1), x_n(:, 2), 'g+', 'MarkerSize',10, 'LineWidth',2);

hold on; plot(x_p_sample(:, 1), x_p_sample(:, 2), 'r.');
hold on; plot(x_n_sample(:, 1), x_n_sample(:, 2), 'g.');

eclipse_x = @(x0, a) x0 + 2*a*cos(linspace(0, 2*pi, 1000));
eclipse_y = @(y0, b) y0 + 2*b*sin(linspace(0, 2*pi, 1000));
for i = 1:size(x_p, 1)
    hold on; plot(eclipse_x(x_p(i, 1), sqrt(sigma_p(i, 1))), eclipse_y(x_p(i, 2), sqrt(sigma_p(i, 2))), 'r');
end
for i = 1:size(x_n, 1)
    hold on; plot(eclipse_x(x_n(i, 1), sqrt(sigma_n(i, 1))), eclipse_y(x_n(i, 2), sqrt(sigma_n(i, 2))), 'g');    
end


y0 = @(x) (w0(1)*x + b0)/-w0(2);
y1 = @(x) (w1(1)*x + b1)/-w1(2);
y2 = @(x) (w2(1)*x + b2)/-w2(2);
x0 = linspace(0, 5, 100);
hold on; plot(x0, y0(x0), 'b--', 'LineWidth',2);
hold on; plot(x0, y1(x0), 'm-', 'LineWidth', 2);
hold on; plot(x0, y2(x0), 'k--', 'LineWidth',2);
