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
intensity_values = linspace(0, 1, N);
x_low_index = 0;
x_high_index = N;

for i=1:N
    if intensity_values(i) == x_low
        x_low_index = i;
    end
    if intensity_values(i) == x_high
        x_high_index = i;
    end
end

lut = zeros(1, N);

range = x_high_index - x_low_index;
k = 1/(range+1);

for i=1:N
    value = 0;
    if i > x_high_index
        value = 1;
    elseif i > x_low_index
        value = (i-x_low_index)*k;
    end
    lut(i) = value;
end
