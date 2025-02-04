# Image Compression using Singular Value Decomposition (SVD)

## Author

**Cristian Vázquez**  
Master in Computational and Applied Mathematics  
Universidad Carlos III de Madrid  

## Contents

This repository contains an implementation of **image compression** using **Singular Value Decomposition (SVD)** in MATLAB. The method allows for a reduced storage size while maintaining a high-quality approximation of the original image. It also includes the calculation of the compression rate of each image.

### Files in this repository:

- **`compress.m`** – MATLAB function for compressing images using SVD.  
- **`image_to_compress.jpg`** – The original image used for testing.  
- **`compressed_*.jpg`** – Resulting compressed images at different rank levels.  
- **`Image_Compression.pdf`** – A detailed report explaining the implementation and results.  
- **`README.md`** – Documentation for the repository.  

## Implementation

### Mathematical Background

Let the original image be represented as an **m × n** matrix, and let **U, Σ, V** be its SVD decomposition:

\[
A = U Σ V^T
\]

To compress the image, only the first **p** singular values are retained. The compressed image approximation is then:

\[
Ap = Up Σp Vp^T
\]

where **Up, Σp, Vp** contain only the first **p** singular values and corresponding vectors.

### Compression Rate

The amount of information required to store the original image is:

\[
3 \times m \times n
\]

(where the factor of 3 accounts for the RGB channels). The storage requirement for a compressed image using **p** singular values is:

\[
3 \times (m \cdot p + p + n \cdot p)
\]

The **compression rate (CR)** is then given by:

\[
CR = \frac{3(m \cdot p + p + n \cdot p)}{3 \cdot m \cdot n}
\]

This ratio indicates the reduction in storage compared to the original image.

## Running the Code

### 1. Setup
Ensure that MATLAB is installed and that the working directory contains:
- The script `compress.m`
- The test image `image_to_compress.jpg`

### 2. Run the MATLAB script
Execute the following command in MATLAB:

```matlab
run('compress.m');
