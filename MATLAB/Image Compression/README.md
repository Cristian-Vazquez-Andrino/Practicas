# Image Compression using Singular Value Decomposition (SVD)

## Author

Cristian Vázquez 


## Contents

This repository contains an implementation of **image compression** using **Singular Value Decomposition (SVD)** in MATLAB. The method allows for a reduced storage size while maintaining a high-quality approximation of the original image. It also includes the calculation of the compression rate of each image.

### Files in this repository:

- **`compress.m`** – MATLAB function for compressing images using SVD.  
- **`image_to_compress.jpg`** – The original image used for testing.  
- **`compressed_*.jpg`** – Resulting compressed images at different rank levels.  
- **`Image_Compression.pdf`** – A detailed report explaining the implementation and results.  
- **`README.md`** – Documentation for the repository.  

## Implementation

The MATLAB function `compress.m` performs **image compression** using **Singular Value Decomposition (SVD)**. The original image is read and decomposed into three color channels (RGB). Each channel is processed separately using SVD, where only the first **p** singular values are retained to create a lower-rank approximation of the image.

The function follows these steps:

1. **Read and validate the image** – The function loads the image and ensures that the chosen rank **p** is appropriate for its resolution.
2. **Apply SVD** – Each RGB color channel is decomposed using MATLAB’s `svd` function.
3. **Reconstruct the image** – The image is approximated by keeping only the first **p** singular values and their corresponding vectors.
4. **Calculate the rate of compression** – The function computes the ratio between the storage size of the compressed image and the original image. This is determined based on the number of retained singular values.
5. **Display and store results** – The compressed image is shown and stored for comparison with the original.

By adjusting **p**, different levels of compression can be achieved, balancing storage size and image quality.

## Running the Code

1. Ensure that the working directory contains the script `compress.m` and the test image `image_to_compress.jpg`

2. Execute the following command in MATLAB:

```matlab
run('compress.m');
