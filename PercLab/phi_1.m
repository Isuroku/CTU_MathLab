function phi = phi_1( data )


phi = zeros(8256,26);

% IndexTable = zeros(26,1);
IndexTable1 = cell(26,1);
IndexTable2 = cell(26,1);

I = [IndexTable1 IndexTable2];

for i = 1:length(data.TrnData)
    word = data.TrnData(i).Y;
    for j = 1:length(word)
        letter = word(j);
        IndexAlf = double(letter) - double('a') + 1;
    end
end


end

