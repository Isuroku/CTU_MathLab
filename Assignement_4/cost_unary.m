function cost = cost_unary(rgb, lab_in, priors1, means1, covs1, ...
	priors2, means2, covs2)
% Compute unary costs for the given RGB values using two estimated GMMs
% determined by their priors, means and covariances.
%
% Input:
%   rgb [3xN (double)] RGB colors of N=HxW input pixels
%   lab_in [HxW (double)] initial labeling of pixels; label 0 denotes
%     unknown pixel, label 1 foregroung, label 2 background
%   priors1 [1xK (double)] prior probabilities for foreground GMM
%   means1 [DxK (double)] mean vectors for foreground GMM
%   covs1 [DxDxK (double)] covariance matrices for foreground GMM
%   priors2 [1xK (double)] prior probabilities for background GMM
%   means2 [DxK (double)] mean vectors for background GMM
%   covs2 [DxDxK (double)] covariance matrices for background GMM
%
% Output:
%   cost [2xN (double)] unary costs for all input pixels; cost(1,:) are
%     costs for class 1 (foreground), cost(2,:) for class 2 (background)

% TODO: Replace with your own implementation.

[H W] = size(lab_in);
N = size(rgb, 2);

lab_in = reshape(lab_in, [1 H*W]);
cost = zeros(2, size(rgb, 2));

for i = 1:N
    
    if lab_in(i) == 1
        cost(2,i) = inf;
        p1 = gmm_prob(rgb(:,i), priors1, means1, covs1);
        cost(1,i) = -log(p1);
    end
    
    if lab_in(i) == 2
        cost(1,i) = inf;
        p2 = gmm_prob(rgb(:,i), priors2, means2, covs2);
        cost(2,i) = -log(p2);
    end
    
    if lab_in(i) == 0
        p1 = gmm_prob(rgb(:,i), priors1, means1, covs1);
        p2 = gmm_prob(rgb(:,i), priors2, means2, covs2);
        cost(2,i) = -log(p2);
        cost(1,i) = -log(p1);
     
    end
    
end
end
