function [priors, means, covs] = gmm_estimation(x, c)
% Estimate Gaussian mixture model (GMM) by maximizing the likelihood.
% The input is formed by sample vectors split to clusters. Each cluster
% corresponds to one GMM component. The output is formed by estimated prior
% probabilities, mean vectors and covariance matrices for all components.
%
% Input:
%   x [DxN (double)] N data sample vectors of dimension D from which GMM
%     should be estimated
%   c [1xN (double)] identifier of the cluster to which the corresponding
%     sample is assigned; there are totally K = max(c) clusters which are
%     named as 1, 2, ..., k
%
% Output:
%   priors [1xK (double)] prior probabilities of individual GMM components
%   means [DxK (double)] mean vectors of individual GMM components
%   covs [DxDxK (double)] covariance matrices of individual GMM components

% TODO: Replace with your own implementation.
d = size(x, 1);
T = length(x);
k = max(c);
N = length(x);

for i=1:k
    x_c = x(:,c == i);
    Ck = length(find(c == i));
    priors(i) = Ck/T;
    for j = 1:d
        x_c_j = x_c(j,:);
        means(j,i) = sum(x_c_j)/Ck;
    end
    covs(:,:,i) = cov(x_c',1);
end



%priors = ones(1, k) / k;
%means = rand(d, k);
%covs = repmat(0.01 * eye(d), [1 1 k]);

% NOTE: You can use function cov(x, 1) as described in the assignment.

end
