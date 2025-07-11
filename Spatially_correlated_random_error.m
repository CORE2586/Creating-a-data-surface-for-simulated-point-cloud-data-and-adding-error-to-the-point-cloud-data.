% 1. Reading point cloud data files (text files containing XYZ coordinates)
data = load('z=0.txt'); % Replace with the file path to your point cloud data

% 2. Construct a Gaussian semi-variogram (spatial autocorrelation function) with a range parameter of 10 (adjustable as required)
range = 10;
n = size(data, 1);

% Initialize the Gaussian semi-variogram
gaussian_semivariogram = zeros(n, 1);

% 3. Generate random error values for the Z-coordinate from the stochastic error distribution
mean_error = 0;
std_deviation = 0.4;
random_error_z = std_deviation * randn(n, 1) + mean_error;

% 4. Compute the Gaussian semi-variogram and apply it to analyze random errors
for i = 1:n
    % Initialize the computational results
    semivariogram_value = 0;
    
    for j = i+1:n
        % Compute spatial separation distances among random errors
        distance = abs(random_error_z(i) - random_error_z(j));
        
        % Compute Gaussian semi-variogram values and incorporate them into the computational results
        semivariogram_value = semivariogram_value + (1 - exp(-distance^2 / (2 * range^2)));
    end
    
    % Assign the computational results to their corresponding spatial locations
    gaussian_semivariogram(i) = semivariogram_value;
    
    % Apply the semi-variogram values to characterize spatial dependence in random errors
    random_error_z(i) = random_error_z(i) * semivariogram_value;
end

% 5. Apply random errors to the Z-coordinates within the point cloud dataset
noisy_point_cloud = data;
noisy_point_cloud(:, 3) = noisy_point_cloud(:, 3) + random_error_z;

% 6. The noisy_point_cloud dataset now incorporates spatially autocorrelated random errors modeled using a Gaussian semi-variogram function.
% Export the noisy_point_cloud dataset to a new file if required
% ：For instance, implement the following code to persist the dataset as a new text file:
save('222-R100.txt', 'noisy_point_cloud', '-ascii');



