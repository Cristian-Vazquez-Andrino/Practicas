# Fuzzy Clustering

## Author
Cristian Vázquez


## Contents
- **Fuzzy_Clustering.pdf**: Main document explaining fuzzy clustering theory and methodology.
- **code/**: Folder containing Python scripts.
  - `fuzzy_cmeans.py`: Implementation of the basic FCM algorithm (Listing 1 in the appendix).
  - `gustafson_kessel.py`: Implementation of the Gustafson-Kessel algorithm (Listing 2 in the appendix).
  - `image_segmentation.py`: Image segmentation using fuzzy clustering (Listing 3 in the appendix).
- **README.md**: Explanation of the repository and usage guide.

## Description
Fuzzy clustering is an unsupervised learning technique that assigns degrees of membership to different categories rather than strict classification. This repository includes:
- Explanation of **clustering methods**.
- Implementation of the **Fuzzy c-Means (FCM) algorithm**.
- Applications such as **image segmentation** and **advanced algorithm variants** like **Gustafson-Kessel**.

## Usage
To run the scripts, install the required dependencies:
``bash
pip install numpy matplotlib scikit-fuzzy scikit-image scipy

Then, execute the scripts in the code/ folder based on the analysis you want to perform.
## Structure of the Scripts
The Python scripts are organized according to the sections of the document:

- fuzzy_cmeans.py: Implements the basic FCM algorithm (Listing 1 in the appendix). This script generates synthetic 2D data and applies the standard fuzzy c-means clustering algorithm. It visualizes the clustering results by plotting membership level curves and cluster centroids.
- gustafson_kessel.py: Implements the Gustafson-Kessel algorithm (Listing 2 in the appendix). This algorithm extends FCM by using adaptive covariance matrices to better model clusters with different shapes. It applies the algorithm to a synthetic dataset and visualizes the results with contour plots showing the cluster membership functions.
- image_segmentation.py: Uses the FCM algorithm for segmenting images based on pixel intensity (Listing 3 in the appendix). The script loads a grayscale image, applies fuzzy c-means clustering to segment different regions, and reconstructs the segmented image. It is particularly useful for medical imaging and object detection tasks.
