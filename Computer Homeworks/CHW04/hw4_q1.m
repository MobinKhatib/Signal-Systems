clear; clc; close all;

iprime =imread('ford2.png'); 
I = imread('ford2.png');

I = im2double(I);
kernel = [-1 -2 -1;...
    0 0 0;...
    1 2 1];


Igray = rgb2gray(I);
imshow(Igray);

I_new1 = conv2(Igray,kernel,'same');

I_new2 = conv2(Igray,kernel','same');

I_new = sqrt(I_new1.^2 + I_new2.^2);
%I_new = imbinarize(I_new);
figure;
imshow(I_new);


%% question 1 part 2

clear; clc; close all;

I = imread('ford2.png');

I = im2double(I);
kernel1 = [5 5 5;...
    -3 0 -3;...
    -3 -3 -3];

kernel2 = [5 5 -3;...
    5 0 -3;...
    -3 -3 -3];
kernel3 = [5 -3 -3;...
    5 0 -3;...
    5 -3 -3];
kernel4 = [-3 -3 -3;...
    5 0 -3;...
    5 5 -3];
kernel5 = [-3 -3 -3;...
    -3 0 -3;...
    5 5 5];
kernel6 = [-3 -3 -3;...
    -3 0 5;...
    -3 5 5];
kernel7 = [-3 -3 5;...
    -3 0 5;...
    -3 -3 5];
kernel8 = [-3 5 5;...
    -3 0 5;...
    -3 -3 -3];






Igray = rgb2gray(I);
imshow(Igray);

I_new1 = conv2(Igray,kernel1,'same');

I_new2 = conv2(Igray,kernel2,'same');
I_new3 = conv2(Igray,kernel3,'same');
I_new4 = conv2(Igray,kernel4,'same');
I_new5 = conv2(Igray,kernel5,'same');
I_new6 = conv2(Igray,kernel6,'same');
I_new7 = conv2(Igray,kernel7,'same');
I_new8 = conv2(Igray,kernel8,'same');

%I_new = sqrt(I_new1.^2 + I_new2.^2);
I_new = max(I_new1,I_new2);
I_new = max(I_new,I_new3);
I_new = max(I_new,I_new4);
I_new = max(I_new,I_new5);
I_new = max(I_new,I_new6);
I_new = max(I_new,I_new7);
I_new = max(I_new,I_new8);


I_new = imbinarize(I_new);
figure;
imshow(I_new);


