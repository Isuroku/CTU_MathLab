function vertex_cost = seam_cost_standard(img, mask_delete, mask_protect)
% Compute vertex costs for seam carving task. The vertex costs for
% individual pixels are based on the estimated image gradient.
%
% Input:
%   img [MxNx3 (double)] input RGB image
%   mask_delete [MxN (logical)] matrix specyfing pixels for which vertex
%     cost must be low enough to ensure their priority carving
%   mask_protect [MxN (logical)] matrix specyfing pixels for which vertex
%     cost must be low enough to ensure their priority carving
%
% Output:
%   vertex_cost [MxN (double)] vertex costs for individual pixels based on
%     on the estimated image gradient and binary masks specifying pixels
%     to be deleted and protected

% estimate partial derivatives and compute vertex_cost

img_gray = rgb2gray(img);

[M,N] = size(img_gray);
Cv = zeros(M,N);

Soper = [1/8,1/4,1/8;0,0,0;-1/8,-1/4,-1/8];
SoperT = Soper';

%Cv = conv2(img_gray, Soper) + conv2(img_gray, SoperT);
Cv = conv2(img_gray, Soper);

%Cv = img_gray * Soper + img_gray * SoperT;

if exist('mask_delete', 'var')
    for i = 1:M
        for j = 1:N
            if mask_delete(i,j) == true
                Cv(i,j) = -2 * M;
            end
        end
    end
end

if exist('mask_protect', 'var')
    for i = 1:M
        for j = 1:N
            if mask_protect(i,j) == true
                Cv(i,j) = 2 * M;
            end
        end
    end
end

vertex_cost = Cv;

end
