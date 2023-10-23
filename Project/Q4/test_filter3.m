clear;
clc;

Hd = bpf1to30Hz;
filt = Hd.Numerator;
N = length(filt);

gd1 = groupdelay(filt, N);
gd2 = grpdelay(filt, 1, N);
subplot(2,1,1);
HalfBandFrequencyDomain(gd1);
title('groupdelay');
subplot(2,1,2);
HalfBandFrequencyDomain(gd2);
title('grpdelay');
