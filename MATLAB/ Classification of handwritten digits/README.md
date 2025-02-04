
# Classification of Handwritten Digits

## Author
Cristian Vázquez Andrino

## Problem Statement
This project addresses the classification of handwritten digits using the US Post Office Zip Code dataset. The dataset consists of:
- A training set with 7,291 handwritten digits.
- A test set with 2,007 handwritten digits.

The goal is to:
1. Classify the training dataset into 10 subsets, each corresponding to digits 0 through 9.
2. Implement a classification algorithm based on Singular Value Decomposition (SVD) using the 10 largest singular values.
3. Test the classification algorithm on a set of 20 handwritten digits and evaluate its accuracy.
4. Analyze the relative residuals of the classification to understand classification confidence.

## Contents
The repository contains the following files:
- `Classification_of_handwritten_digits.pdf`: A detailed report with explanations, results, and conclusions.
- `ClassificationOfDigits.m`: MATLAB implementation of the classification algorithm.
- `zipdata.mat`: The dataset containing the training and test sets.
- `README.md`: This document explaining the project.

## Implementation Steps
1. **Dataset Loading**: The dataset is loaded from `zipdata.mat`, which includes `azip.mat`, `testzip.mat`, `dzip.mat`, and `dtest.mat`.
2. **Data Preprocessing**: The training dataset is split into 10 subsets based on digit labels.
3. **SVD-Based Classification**: The first 10 left singular vectors of each digit subset are extracted to form a classification basis.
4. **Prediction**: Each test digit is projected onto the bases, and the classification is done based on the minimum residual norm.
5. **Accuracy Evaluation**: The algorithm is tested on 20 digits, and the classification accuracy is calculated.
6. **Residual Analysis**: The relative residuals of the classification are plotted to assess classification confidence.

## Running the Code

1. Download the script `ClassificationOfDigits.m` and the dataset `zipdata.mat`.

2. Ensure that the working directory contains the script `ClassificationOfDigits.m` and the dataset `zipdata.mat`.

3. Execute the following command in MATLAB:

```matlab
   classification_code;
