import numpy as np
import matplotlib.pyplot as plt
from skfuzzy.cluster import cmeans
from matplotlib.ticker import FormatStrFormatter
from scipy.spatial.distance import cdist

# Generate synthetic dataset in R^2
np.random.seed(19)

# Parameters for the clusters
mean_upper = [-0.5, 0.5]
std_upper = [0.2, 0.2]
mean_lower = [0.5, -0.5]
std_lower = [0.2, 0.05]

# Generate random samples for each cluster
num_samples = 40
upper_cluster = np.random.normal(mean_upper, std_upper, (num_samples, 2))
lower_cluster = np.random.normal(mean_lower, std_lower, (num_samples, 2))

# Combine the clusters into one dataset
data = np.vstack((upper_cluster, lower_cluster))
data = data.T  # Transpose to match scikit-fuzzy's input format

# Fuzzy C-Means (FCM) parameters
num_clusters = 2
m = 2  # fuzziness parameter
epsilon = 0.01  # convergence threshold
max_iter = 100  # maximum number of iterations

# Apply Fuzzy C-Means algorithm
cntr, u, u0, d, jm, p, fpc = cmeans(data, c=num_clusters, m=m, error=epsilon, maxiter=max_iter, init=None)

# Cluster membership values
cluster_membership = np.argmax(u, axis=0)

# Generate a grid of points for membership level curves
x = np.linspace(-1, 1, 200)
y = np.linspace(-1, 1, 200)
X, Y = np.meshgrid(x, y)
grid = np.c_[X.ravel(), Y.ravel()]  

# Calculate distances to cluster centers and membership values manually
distances = cdist(grid, cntr)  # Compute distances to each cluster center
inverse_distances = 1.0 / np.fmax(distances, np.finfo(np.float64).eps)  # Avoid divide by zero
u_grid = (inverse_distances.T / np.sum(inverse_distances, axis=1)).T  # Normalise memberships

# Plot the results
plt.figure(figsize=(8, 8))

# Scatter plot for the clusters
colors = ['r', 'b']
for i in range(num_clusters):
    plt.scatter(data[0, cluster_membership == i], data[1, cluster_membership == i], c=colors[i], s=30)

# Mark cluster centers
plt.scatter(cntr[:, 0], cntr[:, 1], marker='+', s=200, c='black')

# Plot membership level curves
for i in range(num_clusters):
    Z = u_grid[:, i].reshape(X.shape)  # Reshape each cluster's membership to (200, 200)
    plt.contour(X, Y, Z, levels=np.linspace(0.1, 0.9, 40), colors='black', alpha=0.7)
    # Add shaded region for membership around 0.5
    plt.contourf(X, Y, Z, levels=[0.48, 0.52], colors=['gray'], alpha=0.1)

# Axis formatting
plt.xlim([-1, 1])
plt.ylim([-1, 1])
plt.xticks([-1, -0.5, 0, 0.5, 1])  # Set the x-axis ticks
plt.yticks([-1, -0.5, 0, 0.5, 1])  # Set the y-axis ticks
plt.gca().xaxis.set_major_formatter(FormatStrFormatter('%g'))
plt.gca().yaxis.set_major_formatter(FormatStrFormatter('%g'))
plt.show()
