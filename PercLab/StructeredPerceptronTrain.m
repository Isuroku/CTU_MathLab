function [ BestWeight ] = StructeredPerceptronTrain( data, weights )

NumberOfMistakes = 1;
MinimumMistake = inf;
MinimumCircleCount = 20;
CircleCount = 0;
LetterErrors = zeros(26,2);
for i = 1:26
    LetterErrors(i,1) = i;
end

while NumberOfMistakes > 0 && CircleCount < MinimumCircleCount
    NumberOfMistakes = 0;
    CircleCount = CircleCount + 1;
    LetterErrors(:,2) = 0;
    for w = 1: length(data)
            word = data(w).Y;
            for l = 1:length(word)
                letter = word(l);
                IndexAlf = double(letter) - double('a') + 1;
                features = data(w).X;
                [found_letter let_index] = Letter_Search(word, weights, features(:,l));
                if letter ~=  found_letter
                    phi1 = features(:,l);
                    phi2 = features(:,let_index);
                    weights(:,IndexAlf) = weights(:,IndexAlf) + phi1 - phi2;
                    NumberOfMistakes = NumberOfMistakes + 1;
                    LetterErrors(IndexAlf,2) = LetterErrors(IndexAlf,2) + 1;
                end
            end
    end
    if NumberOfMistakes < MinimumMistake
        MinimumMistake = NumberOfMistakes;
        CircleCount = 0;
        BestWeight = weights;
        MinimumMistake;
    end
end

end

