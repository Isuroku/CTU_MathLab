function [x_low, x_high] = range_by_quantiles(cdf, p_low, p_high)

len = length(cdf);
x_low = 0;
x_high = len;

for i=1:len
    if cdf(i) <= p_low
        x_low = i;    
    end
    if cdf(i) >= p_high && x_high == len
        x_high = i;      
    end
end


%intensity_values = linspace(0, 1, N);

% while cdf(i) <= p_low
%     if x_low < intensity_values(i)
%         x_low = intensity_values(i);
%     end
%     i = i + 1;
% end
% 
% while cdf(N) >= p_high
%     if x_high > intensity_values(N)
%         x_high = intensity_values(N);
%     end
%     N = N - 1;
% end
        
    

% function [x_low, x_high] = range_by_quantiles(cdf, p_low, p_high)
%
% cdf:   the CDF of an image. 
% 
% x_low is the highest intensity x for which CDF(x) <= p_low. 
%       If no such point exists, output x_low = 0.0. 
% 
% x_high is the lowest intensity x for which CDF(x) >= p_high. 
%       If no such point exists, output x_high = 1.0. 
%
% Example usage: 
% ==============
% Find x_low and x_high in order to subsequently map
% x_low -> 0 and x_high -> 1, discarding 1% of pixels 
% at both ends of intensity axis. 
% 
% Finding such x_low and x_high would require:
% 
% [x_low, x_high] = range_by_quantiles(cdf, 0.01, 0.99)


%=======================================================
% remove the following lines and implement the function:

