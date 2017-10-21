function lut = lut_from_range(x_low, x_high, N)
% function lut = lut_from_range(x_low, x_high, N)
%
% creates LUT with N elements which: 
% 
% =0 for x<=x_low
% =1 for x>=x_high
% goes linearly from 0 to 1 between x_low and x_high

%=======================================================
% remove the following lines and implement the function.
% NOTE: use interp1 for implementing this function.

lut = zeros(1, N);
range = x_high - x_low;
k = 1/range;

for i=1:N
    value = 0;
    if i >= x_high
        value = 1;
    elseif i > x_low
        value = (i-x_low)*k;
    end
    lut(i) = value;
end
