function lut_out = constrained_lut(lut_in, max_slope, epsilon)
% function lut_out = constrained_lut(lut_in, max_slope, epsilon)
% 
% for an input LUT 'lut_in', this function computes 'lut_out'
% which:
%
% - has slope which is <= [max_slope * (1+epsilon)] everywhere
% - is close to lut_in
% - lut_in(end) = lut_out(end)
%
% The algorithm works by repeatedly redistributing mass from violating
% slopes to non-violating slopes. The iterations end when no slope 
% higher than [max_slope * (1+epsilon)]
%
% epsilon (>=0) does not have to be specified, in which case
%    epsilon = 0.01 is used as a default. 
%
% If epsilon=0 then the no slope is > max_slope. If epsilon is set
% to a small number (e.g. 0.01) then the algorithm produces almost
% the same result but in much smaller number of iterations. 

if nargin < 3
    epsilon = 0.01; 
end

data_length = length(lut_in);
dx = 1/(data_length - 1);
slope = zeros(1, data_length);
lut_out = zeros(1, data_length);
max_slope_e = max_slope * (1+epsilon);

slope(1) = lut_in(1) / dx;
for i = 2:data_length
    slope(i) = (lut_in(i)-lut_in(i-1))/dx;
end

figure;
subplot(2,2,1);
plot(slope);

violating_mass = 0;
pass_count = 0;
sum_added_masses = 0;

while violating_mass ~= 0 || pass_count == 0
%while pass_count < 1
    
    violating_mass = 0;
    normal_bin_count = 0;
    non_violating_values = zeros(1, data_length);

    for i = 1:data_length
        violating_value = slope(i) - max_slope_e;
        if violating_value > 0
            violating_mass = violating_mass + violating_value;
            slope(i) = max_slope;
        else
            normal_bin_count = normal_bin_count + 1;
            non_violating_values(i) = 1;
        end     
    end

    mass_for_normal_bin = violating_mass / normal_bin_count;
    sum_added_masses = sum_added_masses + mass_for_normal_bin;

    for i = 1:data_length
        if non_violating_values(i) == 1
            slope(i) = slope(i) + mass_for_normal_bin;
        end
    end
    pass_count = pass_count + 1;
end


figure;
subplot(2,2,2);
plot(slope);

lut_out(1) = dx * slope(1);
for i = 2:length(slope) - 1
    lut_out(i) = dx * slope(i) + lut_out(i-1);
end
lut_out(end) = lut_in(end);


 

