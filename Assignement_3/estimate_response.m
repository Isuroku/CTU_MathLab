function [E, finv] = estimate_response(Z, t, w, lambda)
%ESTIMATE_EXPOSURE Estimate irradiance and response function
%
% [E, finv] = estimate_exposure(Z, t, w, lambda)
%
% Estimate irradiance and the inverse response function from pixel intensities
% from multiple exposures.
%
% Input:
%   Z [NxP double] Pixel intensities.
%     Z(i,j) is the intensity of pixel i in image j.
%   t [1xP double] Exposure times, t > 0.
%   w [NxP double] Weights.
%   lambda [1x1 double] Smoothness violation penalty.
%
% Output:
%   E    [Nx1 double] Irradiance (up to scale).
%   finv [Lx1 double] Inverse response function (up to scale),
%     finv(round(L/2)+1) = 1 (soft constraint).
%

assert(ismatrix(Z));
assert(numel(Z) == numel(w));
assert(size(Z, 2) == numel(t));
assert(all(t(:) > 0));

[N, P] = size(Z);
L = max(Z(:)) + 1;
% Get pixel and image indices.
[i_E, i_t] = ind2sub(size(Z), (1:numel(Z))');

%% TODO: Implement me!
E = zeros([N 1]);
finv = zeros([L 1]);

%N = 3;
%P = 2;

indices_row = 1:1:N*P;
J1 = zeros(1, N*P);
J2 = zeros(1, N*P);
V1 = ones(1, N*P);
V2 = ones(1, N*P) .* (-1);
b = zeros(N*P, 1);

k = 1;
ind = 0;
for j = 1:P
    for i = 1:N
        b(k) = log(t(j)) * sqrt(w(i,j));
        k = k + 1;
    end
end

k = 1;
for j = 1:P
    for i = 1:N
        V1(k) = V1(k) * sqrt(w(i,j));
        k = k + 1;
    end
end

k = 1;
for j = 1:P
    for i = 1:N
        V2(k) = V2(k) * sqrt(w(i,j));
        k = k + 1;
    end
end

k = 1;
for j  = 1:P
    for i = 1:N
        J1(k) = Z(i,j) + 1;
        k = k + 1;
    end
end

shift = 0;
for p = 1:P
    for n = 1:N
        J2(n+shift) = n + L;
    end
    shift = shift + N;
end

J = [J1, J2];
I = [indices_row, indices_row];
V = [V1, V2];

A = sparse(I, J, V);

b(N*P + 1, 1) = 0;
A(N*P + 1, floor(L/2 + 1/2)) = 1;

k = 1;
for z = 2:(L-1)
    A(N*P + 1 + k, z - 1) = 1 * sqrt(lambda);
    A(N*P + 1 + k, z) = -2 * sqrt(lambda);
    A(N*P + 1 + k, z+1) = 1 * sqrt(lambda);
    k = k + 1;
end

K = k - 1;
for i = 1:K
    b(N*P + 1 + i, 1) = 0;
end
%%

x = A\b;


for i = 1:L
    finv(i) = exp(x(i));
end
finv(round(L/2)+1) = 1;

for i = L+1:N
    E(i) = exp(x(i));
end

plot(finv);

assert(numel(finv) == L);
assert(numel(E) == N);

end
