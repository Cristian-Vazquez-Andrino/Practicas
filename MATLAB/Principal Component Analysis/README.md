# Principal Component Analysis (PCA) in MATLAB

## Author

Cristian Vázquez Andrino

## Problem Statement

This repository contains an implementation of Principal Component Analysis (PCA) in MATLAB, based on data from [Places Rated Almanac](https://online.stat.psu.edu/stat505/lesson/11/11.3). The dataset consists of ratings for 329 communities across 9 different criteria.:

1. Climate and Terrain  
2. Housing  
3. Healthcare & Environment  
4. Crime  
5. Transportation  
6. Education  
7. The Arts  
8. Recreation  
9. Economics  

The goal is to analyze the variance captured by the principal components and visualize the dataset in a lower-dimensional space.

## Contents

- `PCA.pdf` – A detailed report explaining the steps taken in the analysis.
- `pca_script.m` – MATLAB script implementing PCA (not included yet, please add).
- `places.csv` – The dataset (not included, download from the provided source).

## Implementation Steps

1. **Standardization**  
   - Compute the mean and standard deviation for each feature.  
   - Construct the standardized matrix **X̂**.  

2. **Singular Value Decomposition (SVD)**  
   - Compute the SVD of **X̂** using MATLAB's `svd` function.  
   - Extract singular values to determine variance captured by each principal component.  

3. **Variance Analysis**  
   - Compute the cumulative variance captured by the first **p** principal components.  

4. **Projection onto Principal Components**  
   - Project the observations onto the first two principal components.  
   - Plot the projected data.  

5. **Comparison with MATLAB's `pca` function**  
   - Use MATLAB's built-in `pca` function to validate results.  

## Running the Code

1. Download the dataset from [Places Rated Almanac](https://online.stat.psu.edu/stat505/lesson/11/11.3), save it as `places.csv` and make sure that it is located in the same working directory as the script.  
2. Run the MATLAB script:  

   ```matlab
   run('pca_script.m')

