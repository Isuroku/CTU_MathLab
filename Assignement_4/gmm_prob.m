function prob = gmm_prob(x, priors, means, covs)
% Compute probabilities of the specified samples in GMM. The probability
% distribution is specified by prior probabilities, mean vectors and
% covariance matrices of individual components.
%
% Input:
%   x [DxN (double)] N data sample vectors of dimension D for which
%     logarithms of likelihood probabilities should be evaluated
%   priors [1xK (double)] prior probabilities of individual GMM components
%   means [DxK (double)] mean vectors of individual GMM components
%   covs [DxDxK (double)] covariance matrices of individual GMM components
%
% Output:
%   prob [1xN (double)] probabilities for all N input data samples given
%     by the specified GMM distribution

% TODO: Replace with your own implementation.
[D K]= size(means);
N = size(x,2);
prob = zeros(1, N);
const1 = (2*pi)^(-D/2);

for i = 1:N
    tmp = 0;
    for j = 1:K
        tmp = const1 * (det(covs(:,:,j)))^(-1/2) * exp(-0.5*(x(:,i) - means(:,j))' * inv(covs(:,:,j))*(x(:,i) - means(:,j))) * priors(j);
        prob(i) = prob(i) + tmp;
    end
end


end
