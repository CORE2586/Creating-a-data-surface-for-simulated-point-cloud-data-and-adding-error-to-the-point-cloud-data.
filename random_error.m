% 1. Reading point cloud data files (text files containing XYZ coordinates)
data = load('T2_rand1.txt'); % Replace with the file path to your point cloud data
[num_rows, ~] = size(data);

% 2. Introduce random errors to the Z-coordinates of the point cloud data (using the same mean and standard deviation as previously defined)
mean_error = 0;
std_deviation = 1.2;
random_error_z = std_deviation * randn(size(data, 1), 1) + mean_error;

% 3. Apply random Z-coordinate errors to the point cloud data
noisy_point_cloud = data(:, 3) + random_error_z;
data_output = [data, noisy_point_cloud, random_error_z];
error_cloud = [data(:, 1), data(:, 2), random_error_z];

% 4. Save the modified data to a text file (without using the '-ascii' option)
% The data_output matrix contains five columns: original X-coordinate, original Y-coordinate, original Z-coordinate, noise-contaminated Z-coordinate, and independently introduced random error values.
output_file = fopen('T2_rand_error.txt', 'w');
for i = 1:num_rows
    fprintf(output_file, '%.8f %.8f %.8f %.8f %.8f\n', data_output(i, :));
end
fclose(output_file);

% Export the modified error-contaminated point cloud independently
output_file1 = fopen('error_cloudT2.txt', 'w');
for i = 1:num_rows
    fprintf(output_file1, '%.8f %.8f %.8f \n', error_cloud(i, :));
end
fclose(output_file1);
