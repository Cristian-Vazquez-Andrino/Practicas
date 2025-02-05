import numpy as np
import matplotlib.pyplot as plt
from skimage import io, color
from skfuzzy.cluster import cmeans

# Load the image in color and grayscale
color_image = io.imread('imagefcm.jpg')  # Original color image
gray_image = color.rgb2gray(color_image)  # Grayscale image for clustering
pixels = gray_image.flatten()

# Configure the FCM algorithm
num_clusters = 3
fuzziness = 2
max_iter = 100
error = 0.005

# Apply FCM
cntr, u, _, _, _, _, _ = cmeans(pixels.reshape(1, -1), c=num_clusters, m=fuzziness, error=error, maxiter=max_iter, init=None)

# Reconstruct the segmented image
cluster_membership = np.argmax(u, axis=0)
segmented_image = cluster_membership.reshape(gray_image.shape)

#Comparison of the color original image and segmented image
fig, ax = plt.subplots(1, 2, figsize=(12, 6))

# Original color image
ax[0].imshow(color_image)
ax[0].set_title('Original Image (Color)')
ax[0].axis('off')  # Hide axes

# Segmented image
ax[1].imshow(segmented_image, cmap='viridis')
ax[1].set_title('Segmented Image')
ax[1].axis('off')  # Hide axes

plt.tight_layout()
plt.show()
