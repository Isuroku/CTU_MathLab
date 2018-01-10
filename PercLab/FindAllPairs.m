function [ AllPairs ] = FindAllPairs( data )

    AllPairs = zeros(1,4);

    for i = 1:length(data)
        word = data(i).Y;

        for j = 1:length(word) - 1
            l1 = word(j);
            l2 = word(j+1);
            pair = [l1 l2];


            [m n] = size(AllPairs);
            for q = 1:m
                found = 0;

                t1 = AllPairs(q,1);
                t2 = AllPairs(q,2);

                pair2 = [t1 t2];

                eq(:) = pair(:) == pair2(:);

                if sum(eq) == 2
                    AllPairs(q,3) = AllPairs(q,3) + 1;
                    found = 1;
                end

            end

            if found == 0
                if m == 1 && i == 1
                    AllPairs(m,1) = char(pair(1));
                    AllPairs(m,2) = char(pair(2));
                    AllPairs(m,3) = 1;
                else
                    AllPairs(m+1,1) = char(pair(1));
                    AllPairs(m+1,2) = char(pair(2));
                    AllPairs(m+1,3) = 1;
                end
            end
        end
    end
    
    max_value = max(AllPairs(:,3));
    %SumOfAllPairs = sum(AllPairs(:,3));
    AllPairs(:,4) = AllPairs(:,3)/max_value;
   

% dlmwrite('matrica.txt', A, 'precision', 3);

% fileID = fopen('matrica.txt','w');
% fprintf(fileID, AllPairs');

end

