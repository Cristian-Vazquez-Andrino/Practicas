function [UC, sigmaC, VC] = compress(imjpg, p)
    % Checking input arguments: imjpg must be a string and p must be a positive number
    if not(isreal(p) & (p > 0))
        disp('THE NUMBER OF SINGULAR VALUES MUST BE POSITIVE');
        UC = '???';
        sigmaC = '???';
        VC = '???';
        return;
    end;
    
    p = int16(p);
    photo = imread(imjpg, 'jpg');
    resolution = size(photo);
    
    % Validating the image resolution
    if min(resolution(1:2)) < p
        disp('THE NUMBER OF SINGULAR VALUES FOR COMPRESSION MUST BE');
        disp('COMPATIBLE WITH THE IMAGE RESOLUTION');
        UC = '???';
        sigmaC = '???';
        VC = '???';
        return;
    end;
    
    % Conversion to double for SVD computation
    f2 = double(photo);
    
    % SVD computation for each RGB component
    for k = 1:3
        [U(:,:,k), sigma(:,:,k), V(:,:,k)] = svd(f2(:,:,k));
    end;
    
    % Reconstruction of the compressed image
    for k = 1:3
        f2r(:, :, k) = U(:, 1:p, k) * sigma(1:p, 1:p, k) * V(:, 1:p, k)';
    end;
    
    % Displaying the compressed image
    image(uint8(round(f2r)));
    
    % Storing output matrices for future manipulation
    for j = 1:3
        for k = 1:p
            sigmaC(k, j) = sigma(k, k, j);
        end;
    end;
    
    UC = U;
    VC = V;
    
    clear k j f2r U V sigma f2;
end


% Applying the compress function to an image with dynamically chosen ranks 
% (the image file should be in the same folder of the script)

% Name of the image file
imageName = ['image_to_compress.jpg'];
photo = imread(imageName);
resolution = size(photo);
max_rank = min(resolution(1:2));  % Determine the maximum rank of the image

% Calculate p values dynamically
p_half = round(max_rank / 2);
p_tenth = round(max_rank / 10);

% Moderate rank - around 100 (if applicable, otherwise use 1/2 rank)
if max_rank >= 100
    p_moderate = 100;
else
    p_moderate = p_half; % If the image is too small, use 1/2 rank instead
end

% Our choice of p = 20 (if applicable, otherwise use 1/10)
if max_rank >= 100
    our_p = 20;
else
    our_p = p_tenth; % If the image is too small, use 1/2 rank instead
end

% Displaying the original image in a separate figure
figure;
imshow(photo);
title('Original Image');

% Displaying the compressed images in separate figures

figure;
compress(imageName, p_tenth);
title('Compressed Image (Rank ~ 1/10)');

figure;
compress(imageName, p_half);
title('Compressed Image (Rank ~ 1/2)');

figure;
compress(imageName, p_moderate);
title('Compressed Image (Moderate Rank)');

figure;
compress(imageName, our_p);
title('Compressed Image (Our Rank)');


% Function to calculate compression rate based on SVD
function cr = calculateCompressionRate(m, n, p)
    % Information stored in the original image
    originalInfo = 3 * m * n;
    
    % Information stored in the compressed image
    compressedInfo = 3 * (m * p + p + n * p);
    
    % Compression rate calculation
    cr = compressedInfo / originalInfo;
end

% Dimensions of the image (example values, replace with actual image dimensions)
[m, n, ~] = size(photo);

% Compute compression rates
rate_tenth = calculateCompressionRate(m, n, p_tenth);
rate_moderate = calculateCompressionRate(m, n, p_moderate);
rate_half = calculateCompressionRate(m, n, p_half);
our_rate = calculateCompressionRate(m, n, our_p);

% Display the compression rates
fprintf('Compression rate for rank ~ 1/10: %.4f\n', rate_tenth);
fprintf('Compression rate for moderate rank: %.4f\n', rate_moderate);
fprintf('Compression rate for rank ~ 1/2: %.4f\n', rate_half);
fprintf('Compression rate for our rank: %.4f\n', our_rate);