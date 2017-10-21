% get an image:
im = get_image('images/L.jpg');


%get histogram and CDF:
Nbins = 256;
[bin_centers, h, cdf] = image_hist_cdf(im, Nbins);


% Showing these three (im, its histogram and CDF) will be quite handy
% for other tasks as well, so why not to put it to a separate
% function. Make the function yourself. It should produce the result
% similar to this one:
showim_hist_cdf(im);

% Now make a simple LUT which performs negative transform:
%lut_neg = linspace(1, 0, Nbins);

% and display it:
%figure();
%plot(bin_centers, lut_neg);

% use it to transform im to negative:
%im_neg = transform_by_lut(im, lut_neg);

% and show it:
%showim_hist_cdf(im_neg);

% Note the differences with the original image its histogram and CDF.
