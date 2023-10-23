% ============================== HalfBandFFT ==============================
%% =============================== Exmple-1 ===============================
clear; clc; close all;

Fs = 120;
t = -10:1/Fs:10-1/Fs;
y = sin(2*pi*20*t) + 2*sin(2*pi*80*t);
Title = '$y[n] = sin(2\pi 20n) + sin(2\pi 120n)$';
figure;
HalfBandFFT(y, Fs, 0, Title);
figure;
HalfBandFFT(y, Fs, 1, Title);

%% =============================== Exmple-2 ===============================

Fs = 300; % 120 , 300
t = -10:1/Fs:10-1/Fs;
f0 = 120;
y = sin(2*pi*f0.*t)./(2*pi*f0.*t);
Title = '$y[n] = sinc(n)$';
figure;
HalfBandFFT(y, Fs, 0, Title);
figure;
HalfBandFFT(y, Fs, 1, Title);

% ================================== END ==================================