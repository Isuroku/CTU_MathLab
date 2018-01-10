function [ letter ] = GetLetter( letter_feature, weights )

    max = 0;
    letter_index = 1;
    [R C] = size(weights);
    letter = 'a';
    for i = 1:C
        w = weights(:,i);
        tmp = dot(w,letter_feature);

        if i == 1
            max = tmp;
        elseif tmp > max
                max = tmp;
                letter = double('a') + i - 1; 
        end

    end


end

