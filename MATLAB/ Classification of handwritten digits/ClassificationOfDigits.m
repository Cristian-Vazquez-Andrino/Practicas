% Load the dataset
load('zipdata.mat');

% 1. Classify training set into 10 sets
subsets = cell(10, 1);
data_flattened = reshape(azip, 256, []);
% Iterate over each digit class (0 to 9)
for digit=0:9
    indices = find(dzip == digit); 
    subsets{digit + 1} = data_flattened(:, indices);
end 
%%% CHECK CLASSIFICATION IS CORRECT BY PLOTTING RANDOM NUMBER IN SUBSETS

% Extract the subset for digit 
digit = 8;  % Choose the digit (8 for example)
subset = subsets{digit + 1};  

% Select a specific sample from the subset from 1 to n_i 
sample_index = 64; 
sample = subset(:, sample_index);  % Extract the sample (column vector)

% Reshape the sample to its original 16x16 form
sample_image = reshape(sample, [16, 16]);

% Display the sample using the ima function
figure;
ima(sample_image); 

% 2. SVD basis classification algorithm (10 largest singular values)
function [predictions, rel_residuals] = svd_algorithm(subsets, testzip, N, k)
    % N : number of digits of test data to be predicted 
    % k : number of singular values to retain
    svd_results = cell(10, 1);
    rel_residuals = zeros(k, N); % Store residuals
    for digit=0:9
        matrix = subsets{digit+1};
        [U, ~, ~] = svd(matrix);
        U_k = U(:, 1:k);
        svd_results{digit + 1} = U_k;
    end

    % Extract the first N digits (for example)
    first_N_digits = testzip(:, :, 1:N);  % (16x16xN)

    % Reshape into a 256xN matrix
    test_set = reshape(first_N_digits, [256, N]);  % Reshape to 256xN
    predictions = zeros(1, N); % Store predictions

    for i=1:20
        distances = zeros(1, k);
        for digit=0:9
            U = svd_results{digit+1};
            distances(digit+1) = norm(test_set(:,i)-U*(U'*test_set(:,i)), 2);
            rel_residuals(digit+1,i)=distances(digit+1) / norm(test_set(:, i), 2);
        end
        % Find the digit with the smallest distance
        [~, predicted_digit] = min(distances);  % Get the index of the smallest distance
        predictions(1, i) = predicted_digit - 1;   % Subtract 1 to match digit
    end
end

%%% PLOT FIRST 20 DIGITS OF TEST SET
% Create a figure
figure(4);
colormap(gray);  % Set grayscale colormap

% Loop through the first 20 digits and plot them
for i = 1:20
    I = first_20_digits(:, :, i);  % Extract the i-th digit (16x16)
    im=mat2gray(1-I);
    subplot(4, 5, i);  % Arrange plots in a 4x5 grid
    imshow(im);
    axis off;  
end

[predictions, ~] = svd_algorithm(subsets, testzip, 20, 10); 

% Calculate the number of correct predictions
num_correct = sum(predictions == dtest(1:20));
% Compute accuracy as a percentage
accuracy = (num_correct / length(predictions)) * 100;
% Display the accuracy
fprintf('Accuracy: %.2f%%\n', accuracy);

% Compute residuals
[~ , rel_residuals] = svd_algorithm(subsets, testzip, 20, 10); 

[num_digits, num_vectors] = size(rel_residuals);
figure;
for i = 1:num_vectors
    subplot(4, 5, i); % Create a 4x5 grid of subplots
    bar(0:num_digits-1, rel_residuals(:, i));
    xlabel('Digit');
    ylabel('Relative Residual');
    title(sprintf('Vector %d', i));
end
sgtitle('Residuals for Test Vectors'); % Add a global title