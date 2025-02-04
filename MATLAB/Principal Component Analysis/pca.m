% Import text file into MATLAB using "Import Data" at the Menu
pcadata = readtable('places.csv'); 
% Convert the first 9 columns to a matrix (ignoring the last column)
X = table2array(pcadata(:, 1:9))'; 
% Transpose to get observations in columns

% 1. Construct matrix X_hat
X_mean = mean(X, 2); % Mean along each row (each feature)
X_centered = X - X_mean; % Center on mean
X_std = std(X, 0, 2);  % Standard normalization by n-1 and along rows
X_hat = X_centered ./ X_std; % Standardization

[U, S, V] = svd(X_hat); % SVD of the standardized matrix

% 3. Obtain the ratio between the accumulated variance captures by the 
% first p principal components and the total variance, for all possible 
% values of p.
singular_values = diag(S);
total_variance = sum(singular_values.^2);
accumulated_variance = cumsum(singular_values.^2) / total_variance;

for p = 1:length(accumulated_variance)
    fprintf(['Captured variance by first %d principal components: ' ...
        '%.4f\n'], p, accumulated_variance(p));
end

% 4. Project onto subspace spanned by first two principal components
% (columns of matrix U from the SVD)

projections_svd = U(:, 1:2)'*X_hat; % projection onto subspace
PC1 = projections_svd(1, :); PC2 = projections_svd(2, :);
figure(1);
scatter(PC1, PC2, 'filled', 'r');
xlabel('First Principal Component');
ylabel('Second Principal Component');
title(['Projection of Observation Vectors onto the First' ...
    ' Two Principal Components']);

% 5. Comparison with MATLAB pca command
% Transposed because data observations need to be in rows, features in 
% columns
[coeff, score, latent] = pca(X_hat');  
% Transpose for comparison with earlier results
projections_pca = score(:, 1:2)'; 
% sign needed to match
projections_pca(2, :) = - projections_pca(2, :); 
figure(2);
scatter(projections_pca(1, :), projections_pca(2, :), 'filled', 'r');
xlabel('First Principal Component');
ylabel('Second Principal Component');
title(['Projection of Observation Vectors onto the First Two ' ...
    'Principal Components']); 

difference = norm(projections_svd - projections_pca);
