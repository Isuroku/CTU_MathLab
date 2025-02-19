function inv_lut = inverse_lut(lut)

len = length(lut);

% Find real range of source hist
left_index = 0;
right_index = len;

for i=1:len
    if lut(i) > 0 && left_index == 0
        left_index = i;    
    end
    if lut(i) >= 0.99 && right_index == len
        right_index = i;      
    end
end
real_range = right_index - left_index;
%-----------------
 
%rotate axis x -> y

shift_left = left_index ~= 1;
shift_right = right_index ~= len;

 
 add_bin_count = 0;
 start_index = 1;
 if shift_left
     add_bin_count = add_bin_count + 1;
     start_index = 2;
 end
 
 if shift_right
     add_bin_count = add_bin_count + 1;
 end
 
 new_x_lut = zeros(1,real_range + add_bin_count);
 new_y_lut = zeros(1,real_range + add_bin_count);
  
 k = 1/len;
 for i=left_index:right_index
     new_y_lut(start_index) = i * k;
     new_x_lut(start_index) = lut(i);
     start_index = start_index + 1;
 end
 
 if shift_right
     new_y_lut(start_index) = 1;
     new_x_lut(start_index) = 1;
 end
 
 inv_lut_bins_pos = linspace(0, 1, len);
 
 inv_lut = interp1(new_x_lut,new_y_lut,inv_lut_bins_pos);
