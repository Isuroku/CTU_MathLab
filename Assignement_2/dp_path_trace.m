function path = dp_path_trace(path_cost, path_idx)
% Trace the shortest vertical path in MxN graph going from arbitrary first
% row vertex to arbitrary last row vertex.
%
% Input:
%   path_cost [MxN (double)] path_cost(i,j) is the total cost of the
%     shortest vertical path starting in arbitrary first row vertex (1,*)
%     and ending in the vertex (i,j)
%   path_idx [MxN (double)] path_idx(i,j) is the column index of vertex
%     preceding the vertex (i,j) on the shortest vertical path from
%     arbitrary first row vertex (1,*) to the vertex (i,j); path_idx(i,j)
%     for i > 1 is from {j-1,j,j+1}; path_idx(1,j) can be aribtrary
%
% Output:
%   path [Mx1 (double)] path(i) = j if the shortest vertical path from
%     the first row to the last row goes through the vertex (i,j)

% add your code here
[M,N] = size(path_cost);
path = zeros(M,1);

[value, index] = min(path_cost(M,:));
path(M,1) = index;



for i = M-1:-1:1
    path(i) = path_idx(i+1, index);
    index = path(i);
end

end
