%% 3.0
clear;
clc;

Im = imread("pencil.jpg");
Im_salt_and_pepper = imnoise(Im, 'salt & pepper');
Im_gaussian = imnoise(Im, 'gaussian');
Im_poisson = imnoise(Im, 'poisson');
Im_speckle = imnoise(Im, 'speckle');

subplot(2,2,1);
imshow(Im_salt_and_pepper);
title('Salt & Pepper');
subplot(2,2,2);
imshow(Im_gaussian);
title('Gaussian');
subplot(2,2,3);
imshow(Im_poisson);
title('Poisson');
subplot(2,2,4);
imshow(Im_speckle);
title('Speckle');

%% 3.1
clear;
clc;

my_image = imread('pencil.jpg');
kernel_size = 21;
deviation = 1;
filtered_image = Gaussian_filter(my_image, kernel_size, deviation);
subplot(2,1,1);
imshow(my_image);
subplot(2,1,2);
imshow(filtered_image);

%% 3.2
clear;
clc;

my_image = imread('pencil.jpg');
kernel_size = 5;
filtered_image = Median_filter(my_image, kernel_size);
imshow(filtered_image);

%% 3.3
clear;
clc;

my_image = imread('pencil.jpg');
% salt & pepper noise
noisy_salt_and_pepper = imnoise(my_image, 'salt & pepper');
subplot(2,2,1);
imshow(noisy_salt_and_pepper);
title('Noisy');

filtered_salt_and_pepper_gaussian = Gaussian_filter(noisy_salt_and_pepper, 21, 1);
subplot(2,2,2);
imshow(filtered_salt_and_pepper_gaussian);
title('Gaussian');

filtered_salt_and_pepper_median = Median_filter(noisy_salt_and_pepper, 3);
subplot(2,2,3);
imshow(filtered_salt_and_pepper_median);
title('Median');

subplot(2,2,4);
imshow(my_image);
title('Without Noise');

%% gaussian noise
clear;
clc;

my_image = imread('pencil.jpg');

noisy_gaussian = imnoise(my_image, 'gaussian', 0.001, 0.001);
subplot(2,2,1);
imshow(noisy_gaussian);
title('Noisy');

filtered_gaussian_gaussian = Gaussian_filter(noisy_gaussian, 30, 1);
subplot(2,2,2);
imshow(filtered_gaussian_gaussian);
title('Gaussian');

filtered_gaussian_median = Median_filter(noisy_gaussian, 4);
subplot(2,2,3);
imshow(filtered_gaussian_median);
title('Median');

subplot(2,2,4);
imshow(my_image);
title('Without Noise');

%% poisson
clear;
clc;

my_image = imread('pencil.jpg');

noisy_poisson = imnoise(my_image, 'poisson');
subplot(2,2,1);
imshow(noisy_poisson);
title('Noisy');

filtered_poisson_gaussian = Gaussian_filter(noisy_poisson, 21, 0.9);
subplot(2,2,2);
imshow(filtered_poisson_gaussian);
title('Gaussian');

filtered_poisson_median = Median_filter(noisy_poisson, 3);
subplot(2,2,3);
imshow(filtered_poisson_median);
title('Median');

subplot(2,2,4);
imshow(my_image);
title('Without Noise');

%% speckle
clear;
clc;

my_image = imread('pencil.jpg');

noisy_speckle = imnoise(my_image, 'speckle', 0.008);
subplot(2,2,1);
imshow(noisy_speckle);
title('Noisy');

filtered_speckle_gaussian = Gaussian_filter(noisy_speckle, 21, 1.2);
subplot(2,2,2);
imshow(filtered_speckle_gaussian);
title('Gaussian');

filtered_speckle_median = Median_filter(noisy_speckle, 4);
subplot(2,2,3);
imshow(filtered_speckle_median);
title('Median');

subplot(2,2,4);
imshow(my_image);
title('Without Noise');

%% 3.4
% SNR
clear;
clc;

my_image = imread('pencil.jpg');

SNR_matrix = zeros(3, 4);

noisy_salt_and_pepper = imnoise(my_image, 'salt & pepper');
filtered_salt_and_pepper_gaussian = Gaussian_filter(noisy_salt_and_pepper, 21, 1);
filtered_salt_and_pepper_median = Median_filter(noisy_salt_and_pepper, 3);

noisy_salt_and_pepper = noisy_salt_and_pepper(30:420, 87:604, :); % resize image
filtered_salt_and_pepper_gaussian = filtered_salt_and_pepper_gaussian(30: 420, 87:604, :); % resize image
filtered_salt_and_pepper_median = filtered_salt_and_pepper_median(30: 420, 90:607, :); % resize image

%......................................................................

noisy_gaussian = imnoise(my_image, 'gaussian', 0.005, 0.008);
filtered_gaussian_gaussian = Gaussian_filter(noisy_gaussian, 30, 1);
filtered_gaussian_median = Median_filter(noisy_gaussian, 4);

noisy_gaussian = noisy_gaussian(30: 420, 87:604, :); % resize image
filtered_gaussian_gaussian = filtered_gaussian_gaussian(30: 420, 87:604, :); % resize image
filtered_gaussian_median = filtered_gaussian_median(30: 420, 90:607, :); % resize image

%...........................................................

noisy_poisson = imnoise(my_image, 'poisson');
filtered_poisson_gaussian = Gaussian_filter(noisy_poisson, 21, 0.9);
filtered_poisson_median = Median_filter(noisy_poisson, 3);

noisy_poisson = noisy_poisson(30: 420, 87:604, :); % resize image
filtered_poisson_gaussian = filtered_poisson_gaussian(30: 420, 87:604, :); % resize image
filtered_poisson_median = filtered_poisson_median(30: 420, 90:607, :); % resize image

%...............................................................

noisy_speckle = imnoise(my_image, 'speckle', 0.008);
filtered_speckle_gaussian = Gaussian_filter(noisy_speckle, 21, 1.2);
filtered_speckle_median = Median_filter(noisy_speckle, 4);

noisy_speckle = noisy_speckle(30: 420, 87:604, :); % resize image
filtered_speckle_gaussian = filtered_speckle_gaussian(30: 420, 87:604, :); % resize image
filtered_speckle_median = filtered_speckle_median(30: 420, 90:607, :); % resize image

my_image = my_image(30: 420, 87:604, :); % resize image

% SNR calcultate
SNR_matrix(1, 4) = SNR(my_image, noisy_speckle);
SNR_matrix(2, 4) = SNR(my_image, filtered_speckle_gaussian);
SNR_matrix(3, 4) = SNR(my_image, filtered_speckle_median);
% SNR calcultate
SNR_matrix(1, 3) = SNR(my_image, noisy_poisson);
SNR_matrix(2, 3) = SNR(my_image, filtered_poisson_gaussian);
SNR_matrix(3, 3) = SNR(my_image, filtered_poisson_median);
% SNR calcultate
SNR_matrix(1, 2) = SNR(my_image, noisy_gaussian);
SNR_matrix(2, 2) = SNR(my_image, filtered_gaussian_gaussian);
SNR_matrix(3, 2) = SNR(my_image, filtered_gaussian_median);
% SNR calcultate
SNR_matrix(1, 1) = SNR(my_image, noisy_salt_and_pepper);
SNR_matrix(2, 1) = SNR(my_image, filtered_salt_and_pepper_gaussian);
SNR_matrix(3, 1) = SNR(my_image, filtered_salt_and_pepper_median);

disp(SNR_matrix);
%% 4.3
clc;
clear;

my_image = imread('flower.png');
s = size(my_image);
k = 4;
x = round(rand(1,4) * (s(1) - 1)) + 1;
y = round(rand(1,4) * (s(2) - 1)) + 1;
clustered_image = cluster(my_image, x, y, k, 10);

imshow(uint8(clustered_image * 255 / 4));

%% 4.6
clc;
clear;

my_image = imread('cat.jpeg');
gray = rgb2gray(my_image);

output = otsu(gray);
subplot(1,2,1);
imshow(gray);
subplot(1,2,2);
imshow(output);
%% Functions
function output_image = filter_func(image, filter)
    kernel_size = length(filter);
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    output_image = zeros(size(image) + [kernel_size - 1, kernel_size - 1, 0]);
    output_image(:, :, 1) = conv2(R, filter);
    output_image(:, :, 2) = conv2(G, filter);
    output_image(:, :, 3) = conv2(B, filter);
    output_image = uint8(output_image);
end
function output_image = Gaussian_filter(image, kernel_size, deviation)
    my_gaussian_filter = fspecial('gaussian', kernel_size, deviation);
    output_image = filter_func(image, my_gaussian_filter);
    image_size = size(image);
    edge = floor(kernel_size / 2);
    output_image = output_image(edge + 1 : image_size(1) + edge, edge + 1: image_size(2) + edge, :);
end
function output_image = Median_filter(image, kernel_size)
    R = image(:, :, 1);
    G = image(:, :, 2);
    B = image(:, :, 3);
    output_image = zeros(size(image));
    output_image(:, :, 1) = median_filter_func(R, kernel_size);
    output_image(:, :, 2) = median_filter_func(G, kernel_size);
    output_image(:, :, 3) = median_filter_func(B, kernel_size);
    output_image = uint8(output_image);
    
    % black border reduction
    image_size = size(image);
    edge = kernel_size;
    output_image(1 : edge, :, :) = 255;
    output_image(image_size(1) - edge : image_size(1), :, :) = 255;
    output_image(:, 1 : edge, :) = 255;
    output_image(:, image_size(2) - edge : image_size(2), :) = 255;
end
function output_image = median_filter_func(matrix, kernel_size)
    matrix_size = size(matrix);
    window = zeros(1,kernel_size);
    edge = ceil(kernel_size / 2);
    output_image = zeros(matrix_size(1), matrix_size(2));
    for x = edge + 1:matrix_size(1) - edge
        
        for i = 1:kernel_size
            for j = 1:kernel_size
                ind = j + (i-1) * kernel_size;
                window(ind) = matrix(x - edge + j, i);
            end
        end
        
        for y = edge+1:matrix_size(2) - edge
            window = window(kernel_size + 1:kernel_size * kernel_size);
            window = [window, matrix(x-floor(kernel_size/2):x-floor(kernel_size/2)+kernel_size, y-edge)'];
            output_image(x, y) = median(window);
        end
    end
end
function value = SNR(source, image)
    size_1 = size(image);
    size_2 = size(source);
    S = source;
    I = image;
    
    if length(size_1) == 3
        I = im2double(rgb2gray(image));
    end
    if length(size_2) == 3
        S = im2double(rgb2gray(source));
    end
    
    
    num = sum(sum(S.^2));
    den = sum(sum((S - I).^2));
    value = 10*log10(num / den);
end
function output_image = cluster(input_image,x,y,k,n) % x and y are initialized cluster centers.
    s = size(input_image);
    output_image = zeros(s(1), s(2));  
    for a = 1:s(1)
        for b = 1:s(2)
            min_dis = inf;
            for i = 1:k
                centroid = double(input_image(x(i), y(i), :));
                image = double(input_image(a, b, :));
                dis = sum((centroid - image).^2);
                if min_dis > dis
                    min_dis = dis;
                    output_image(a, b) = i;
                end
            end
        end
    end
    
    sum_cluster = zeros(k, 2);
    num = zeros(k, 1);
    
    for a = 1:s(1)
        for b = 1:s(2)
            ind = output_image(a, b);
            sum_cluster(ind, 1) = sum_cluster(ind, 1) + a;
            sum_cluster(ind, 2) = sum_cluster(ind, 2) + b;
            num(ind) = num(ind) + 1;
        end
    end
    
    flag = 0;
    for i = 1:k
        temp_x = round(sum_cluster(i, 1) / num(i));
        temp_y = round(sum_cluster(i, 2) / num(i));
        if (x(i) ~= temp_x) || (y(i) ~= temp_y)
            flag = 1;
        end
        x(i) = temp_x;
        y(i) = temp_y;
    end
    
    if flag == 0 || n == 0
        return;
    end
    cluster(input_image, x, y, k, n-1);
end
function output_image = otsu(input_image)
    intensity = zeros(1, 256);
    s = size(input_image);
    number_of_pixels = s(1) * s(2);
    for i = 1:s(1)
        for j = 1:s(2)
            ind = input_image(i, j);
            intensity(ind + 1) = intensity(ind + 1) + 1;
        end
    end
    
    max_var = 0;
    ind = 0;
    for t = 1:255
        Wb = sum(intensity(1:t)) / number_of_pixels;
        Wf = sum(intensity(t+1:256)) / number_of_pixels;
        ub = sum(intensity(1:t) .* (0:t-1)) / sum(intensity(1:t));
        uf = sum(intensity(t+1:256) .* (t:255)) / sum(intensity(t+1:256));
        var = Wb * Wf * (ub - uf)^2;
        if max_var < var
            max_var = var;
            ind = t;
        end
    end
    output_image = input_image > (ind-1);
end


