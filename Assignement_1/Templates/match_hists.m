function lut = match_hists(h, h_target)
% function lut = match_hists(h, h_target)
%
% computes a LUT which brings histogram h close to h_target.

cdf = cumsum(h)/sum(h);
cdf_target = cumsum(h_target)/sum(h_target);

inv_lut = inverse_lut(cdf_target);
lut = transform_by_lut(cdf, inv_lut);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% remove these lines and finish the function: 
%lut = linspace(0, 1, length(h))
