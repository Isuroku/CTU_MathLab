function [ rec_word ] = PercepronTest3( weights, features_word, all_pairs )


    [row, col] = size(features_word);
    alph_count = 26;
    LettersSequence = ones(1, col);
    
    TestWordCount =   alph_count^col;
    
    LettersSequenceMemory = zeros(TestWordCount , col);
    LettersSequenceMemorySum = zeros(TestWordCount , 1);
    
    count = 1;
    while count <= TestWordCount
        
        sum_word = 0;
        for l = 1:col
            w = weights(:,LettersSequence(l));
            lw = dot(w,features_word(:,l));
            sum_word = sum_word + lw;
        end
        
        LettersSequenceMemory(count, :) = LettersSequence(:);
        LettersSequenceMemorySum(count, 1) = sum_word;
        
        LastLetterInd = col;
        while LastLetterInd > 0
            LettersSequence(LastLetterInd) = LettersSequence(LastLetterInd) + 1;
            if LettersSequence(LastLetterInd) > alph_count
                LettersSequence(LastLetterInd) = 1;
                LastLetterInd = LastLetterInd - 1;
            else
                LastLetterInd = 0;
            end
        end
        count = count + 1;
    end
    
    max_sum_word = max(LettersSequenceMemorySum(:,1));
    LettersSequenceMemorySum(:,1) = LettersSequenceMemorySum(:,1) / max_sum_word;
    
    for i =1:length(LettersSequenceMemory)
        sum = 0;
        for j =1:col-1
            sum = sum + GetPairValue(LettersSequenceMemory(i, j), LettersSequenceMemory(i, j));
        end
        LettersSequenceMemorySum(:,1) = LettersSequenceMemorySum(:,1) + sum;
    end
    
    [mv, max_index] = max(LettersSequenceMemorySum(:,1));
    
    rec_word = char(LettersSequenceMemory(max_index,:));
    
end

