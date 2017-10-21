function inv_lut = inverse_lut(lut)



left_index = 0;
right_index = length(lut);

for i=1:length(lut)
    if lut(i) > 0 && left_index == 0
        left_index = i;    
    end
    
    if lut(i) >= 0.99 && right_index == length(lut)
        right_index = i;      
    end
end

real_range = right_index - left_index;

new_x_lut = zeros(1,real_range + 1);
new_y_lut = zeros(1,real_range + 1);
k = length(lut)/real_range;
new_y_lut(1) = lut(left_index);
new_x_lut(1) = 0;
for i=2:real_range+1
    new_y_lut(i) = lut(i+left_index-1);
    new_x_lut(i) = i*k;
end
%new_y_lut(end) = 1;
interp_x_lut = zeros(1,length(lut));
for i=1:length(lut)
    interp_x_lut(i) = i;
end
interp_y_lut = interp1(new_x_lut,new_y_lut,interp_x_lut);
%inv_lut = zeros(1, length(lut));


inv_interp_x_lut = zeros(1,length(lut));
for i=1:length(lut)
    inv_interp_x_lut(i) = i/length(lut);
end

xq = linspace(0,1,length(lut));
inv_lut = interp1(interp_y_lut,inv_interp_x_lut,xq);

subplot(2,2,1);
plot(lut);

subplot(2,2,2);
plot(inv_lut);

