clear;
clc;

N = 200;
M = 200;
Fs = 100;
x = rand(1,N);
h = sinc((-M:M) / 2);
H = fft(h, 2*M+1);

gd = groupdelay(h, 2*M+1);
gd_original = grpdelay(h, 1, 2*M+1);
filtered = conv(h,x);
corrected_filtered = zphasefilter(h, x); % remove gd
filtered_orig = conv(x, h, 'same'); % auto remove gd

subplot(5,1,1);
plot(h);
title('h');
subplot(5,1,2);
plot(x);
title('x');
subplot(5,1,3);
plot(filtered);
title('filtered');
subplot(5,1,4);
plot(corrected_filtered);
title('corrected filtered');
subplot(5,1,5);
plot(filtered_orig);
title('filtered_orig');

