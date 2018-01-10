function [E, t] = estimate_exposure(Z, w)
%ESTIMATE_EXPOSURE Estimate irradiance and exposure time
%
% [E, t] = estimate_exposure(Z, w)
%
% Estimate irradiance and exposure times from pixel intensities from multiple
% exposures.
% 
% Assume that the response function f is identity.
% (Note that if the response function is known you can transform
% the pixel intensities prior to calling this function.)
% 
% Use eps instead of zero Z values for taking the logarithm to avoid
% infinity.
%
% Input:
%   Z [NxP double] Pixel intensities,
%     Z(i,j) corresponds to the intensity of pixel i in image j.
%   w [NxP double] Weights corresponding to Z.
%
% Output:
%   E [Nx1 double] Irradiance (up to scale).
%   t [1xP double] Exposure times (up to scale),
%     t(1) = 1 (soft constraint).
%

assert(ismatrix(Z));
assert(numel(Z) == numel(w));

[N, P] = size(Z);
% Get pixel and image indices.
[i_E, i_t] = ind2sub(size(Z), (1:numel(Z))');

%% TODO: Implement me!
%N = 3;
%P = 2;

E = zeros([N 1]);
t = zeros([1 P]);

%%
V = ones(1, N*P);
k = 1;
for j = 1:P
    for i = 1:N
        V(k) = V(k) * sqrt(w(i,j));
        k = k + 1;
    end
end

V = [V, V];

indices_row = 1:1:N*P;
J1 = zeros(1, N*P);
J2 = zeros(1, N*P);

shift = 0;
for p = 1:P
    for n = 1:N
        J1(n+shift) = n;
    end
    shift = shift + N;
end

Col_index_2 = 1;
Row_index = 0;
for j = 1:N*P
    Row_index = Row_index + 1;
    if Row_index > N
        Row_index = 1;
        Col_index_2 = Col_index_2 + 1;
    end
    J2(j) = N+Col_index_2;
end

J = [J1, J2];
I = [indices_row, indices_row];


A = sparse(I,J,V);
A(N*P + 1, N+1) = 1;


b = zeros([N*P 1]);
k = 1;
for j = 1:P
    for i = 1:N
        b(k) = log(Z(i,j));
        k = k + 1;
    end
end
b(N*P + 1, 1) = 0;

k = 1;
for j = 1:P
    for i = 1:N
        b(k) = b(k) * sqrt(w(i,j));
        k = k +1;
    end
end

%%
x = A\b;


for i = 1:P
    t(i) = exp(x(N+i));
end
plot(t);

for i = 1:N
    E(i) = exp(x(i));
end




%%

assert(numel(E) == N);
assert(numel(t) == P);

end
