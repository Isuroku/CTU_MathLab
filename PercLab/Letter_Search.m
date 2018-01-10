function [ letter, letter_index ] = Letter_Search(word, weights,let_features )

    max = 0;
    letter = word(1);
    letter_index = 1;
    for i = 1:length(word)
        IndexAlf = double(word(i)) - double('a') + 1;
        w = weights(:,IndexAlf);
        tmp = dot(w,let_features);

        if i == 1
            max = tmp;
        elseif tmp > max
                max = tmp;
                letter = word(i);
                letter_index = i;
        end

    end

end

