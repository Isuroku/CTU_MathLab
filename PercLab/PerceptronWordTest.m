function [ rec_word ] = PerceptronWordTest( weights, features_word )

%rec_word = char(double('a') + 1);
[R, C] = size(features_word);
%rec_word = zeros(1,C);

     for l = 1:C
                    found_letter = GetLetter(features_word(:,l), weights);
                    rec_word(l) = found_letter;
    end
end

