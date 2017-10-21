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
lut = linspace(0, 1, N)
intensity_values = linspace(0, 1, N);

% xq = 0:0.01:1
% lut = interp1(intensity_values, v, v, 'linear')

% for i = 1:N
%     if lut(i) <= x_low
%         lut(i) = 0;
%     elseif lut(i) >= x_high
%         lut(i) = 1;
%     end
% end
i = 1
while lut(i) <= x_low
    lut(i) = 0
    i = i + 1;
end

temp = N
while lut(temp) >= x_high
    lut(temp) = 1
    temp = temp - 1;
end

unique_lut = unique(lut);
xq = intensity_values(i-1:temp+1);

for j=1:length(unique_lut)
    unique_lut(j) = interp1(unique_lut,xq,unique_lut(j))
end



figure();
plot(xq,unique_lut);
