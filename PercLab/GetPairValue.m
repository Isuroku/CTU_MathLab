function [ value ] = GetPairValue( a, b, all_pairs )
    value = 0;
    for i=1:length(all_pairs)
        ac = double('a') + a -1;
        bc = double('a') + b -1;
        if ac == all_pairs(i, 1) && bc == all_pairs(i, 2)
            value = all_pairs(i, 3);
            break;
        end
    end
end

