clear;
clc;

b = [0 1];
a = 1;
N = 2;
[gd1, w] = grpdelay(b, a, N);
gd2 = groupdelay(b, N); 