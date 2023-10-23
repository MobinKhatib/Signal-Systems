clear; clc; close all;

x1 = imread('pic1.png');
x2 = imread('pic2.png');


Y2 = fft2(x2);


Y2_mag = abs(Y2);
Y2_phase = angle(Y2);


Y1 = fft2(x1);


Y1_mag = abs(Y1);
Y1_phase = angle(Y1);

Y_new = Y2_mag .* exp(1i * Y1_phase);
x_new = ifft2(Y_new);
figure;

figure;
imshow(mat2gray(log(1+abs(Y1))));
figure;
imshow(mat2gray(log(1+abs(Y2))));
figure;
imshow(mat2gray(x_new));

