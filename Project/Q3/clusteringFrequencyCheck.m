clear;
clc;

load 64channeldata.mat;
channel1_trial1 = data(1, :, 1);
HalfBandFFT(channel1_trial1, 600, 0, 'channel 1 - trial 1');