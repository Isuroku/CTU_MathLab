function lab_out = segmentation_hist(img, lab_in, num_bins, sigma)
% Segment the grayscale image based on various statistical properties
% of the foreground and background pixel intensities. The probability
% distributions of pixel intensities are modeled using histograms.
% The histograms are constructed from the initial partial labeling.
%
% Input:
%   img [HxW (double)] input grayscale image; intensities are from [0, 1]
%   lab_in [HxW (double)] initial labeling of pixels; label 0 denotes
%     unknown pixel, label 1 foregroung, label 2 background
%   num_bins [1x1 (double)] number of histogram bins
%   sigma [1x1 (double)] standard deviation of Gaussian used for histogram
%     smoothing
%
% Output:
%   lab_out [HxW (double)] output labeling of pixels; label 1 denotes
%     foregroung pixel, label 2 background

% TODO: Replace with your own implementation.

[H W] = size(img);
gray_fore = img(lab_in == 1);
hist_fore = hist_pdf(gray_fore, num_bins, sigma);

gray_back = img(lab_in == 2);
hist_back = hist_pdf(gray_back, num_bins, sigma);

for i = 1:H
    for j = 1:W
        y1 = hist_prob(img(i,j), hist_fore);
        y2 = hist_prob(img(i,j), hist_back);
        
        if y2 > y1
            lab_out(i,j) = 2;
        end
        
        if y2 < y1
            lab_out(i,j) = 1;
        end
        
        if y2 == y1
            lab_out(i,j) = randi([0 1])
        end
    end
end

%lab_out = 2 * ones(size(lab_in));

end
