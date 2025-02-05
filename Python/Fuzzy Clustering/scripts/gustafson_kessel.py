import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import det, inv
from matplotlib.ticker import FormatStrFormatter

# Generate synthetic dataset in R^2
np.random.seed(7)

# Parameters for the clusters
mean_upper = [-0.5, 0.5]
std_upper = [0.2, 0.2]
mean_lower = [0.5, -0.5]
std_lower = [0.2, 0.05]

# Generate random samples for each cluster
N = 40  # Number of data points per cluster
upper_cluster = np.vstack([
    np.random.normal(mean_upper[0], std_upper[0], N),
    np.random.normal(mean_upper[1], std_upper[1], N)
])

lower_cluster = np.vstack([
    np.random.normal(mean_lower[0], std_lower[0], N),
    np.random.normal(mean_lower[1], std_lower[1], N)
])

# Combine the clusters into dataset X
X = np.hstack((upper_cluster, lower_cluster))  # Shape: (2, 2N)

# Gustafson-Kessel algorithm parameters
c = 2  # Number of clusters
m = 2  # Fuzziness parameter
epsilon = 0.01  # Convergence threshold
max_iter = 100  # Maximum number of iterations

# Initialize membership matrix randomly
W = np.random.rand(c, X.shape[1])
W = W / np.sum(W, axis=0)

# Iterate to perform GK clustering
for iteration in range(max_iter):
    # Step 1: Calculate cluster prototypes/centers
    Wm = W ** m
    cluster_centers = (X @ Wm.T) / Wm.sum(axis=1, keepdims=True).T  # Cluster centers shape: (2, c)

    # Step 2: Compute covariance matrices
    cov_matrices = []
    for j in range(c):
        diff = X - cluster_centers[:, j].reshape(-1, 1)  # Shape: (2, N)
        weighted_diff = Wm[j] * diff
        cov_matrix = (weighted_diff @ diff.T) / np.sum(Wm[j])
        cov_matrices.append(cov_matrix)

    # Step 3: Update membership matrix
    W_new = np.zeros_like(W)
    for j in range(c):
        for i in range(X.shape[1]):
            diff = X[:, i] - cluster_centers[:, j]
            distance = diff.T @ inv(cov_matrices[j]) @ diff
            norm_term = det(cov_matrices[j]) ** (1 / 2)
            W_new[j, i] = (norm_term * distance) ** (-1 / (m - 1))
    W_new /= np.sum(W_new, axis=0)  # Normalize columns

    # Check for convergence
    if np.linalg.norm(W_new - W) < epsilon:
        print(f"Converged after {iteration} iterations.")
        break
    W = W_new

# Final cluster assignments
cluster_membership = np.argmax(W, axis=0)

# Generate a grid of points for membership level curves
x = np.linspace(-1, 1, 200)
y = np.linspace(-1, 1, 200)
X_grid, Y_grid = np.meshgrid(x, y)
grid = np.vstack((X_grid.ravel(), Y_grid.ravel()))  # Shape: (2, 40000)

# Compute membership values for the grid
grid_memberships = np.zeros((c, grid.shape[1]))
for j in range(c):
    for i, point in enumerate(grid.T):
        diff = point - cluster_centers[:, j]
        distance = diff.T @ inv(cov_matrices[j]) @ diff
        norm_term = det(cov_matrices[j]) ** (1 / 2)
        grid_memberships[j, i] = (norm_term * distance) ** (-1 / (m - 1))
grid_memberships /= np.sum(grid_memberships, axis=0, keepdims=True)

# Plot the results
plt.figure(figsize=(8, 8))

# Scatter plot for the clusters
colors = ['r', 'b']
for i in range(c):
    indices = np.where(cluster_membership == i)
    plt.scatter(X[0, indices], X[1, indices], c=colors[i], s=30)

# Mark cluster centers
plt.scatter(cluster_centers[0, :], cluster_centers[1, :], marker='+', s=200, c='black')

# Plot membership level curves
for j in range(c):
    Z = grid_memberships[j].reshape(X_grid.shape)
    plt.contour(X_grid, Y_grid, Z, levels=np.linspace(0, 0.5, 20), colors='black', alpha=0.7)
    plt.contourf(X_grid, Y_grid, Z, levels=[0.48, 0.52], colors=['gray'], alpha=0.15)

# Axis formatting
plt.xlim([-1, 1])
plt.ylim([-1, 1])
plt.xticks([-1, -0.5, 0, 0.5, 1])
plt.yticks([-1, -0.5, 0, 0.5, 1])
plt.gca().xaxis.set_major_formatter(FormatStrFormatter('%g'))
plt.gca().yaxis.set_major_formatter(FormatStrFormatter('%g'))
plt.show()
