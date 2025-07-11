% 1. read data
data = load('T2_rand1.txt'); 
[num_rows, ~] = size(data);


% 2. Generate systematic error values
a = 0;
b = 250;
value1 = a + (b - a) * rand; 
systematic_error = (2value1 / 300) -1

% 3. Add the error values to the read coordinate data
noisy_point_cloud = data + systematic_error;
error_cloud = noisy_point_cloud;


% 4. Save the processed point cloud coordinate file
output_file1 = fopen('error_cloudT2.txt', 'w');
for i = 1:num_rows
    fprintf(output_file1, '%.8f %.8f %.8f \n', error_cloud(i, :));
end
fclose(output_file1);
