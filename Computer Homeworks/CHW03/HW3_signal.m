clear; clc; close all;
fileName = 'Old_McDonald.wav';

[m,Fs] = audioread(fileName);
plot(m);

miu = 0.7;
f0 = 200;
Ac = 0.1;
x1 = Ac.*(1+miu.*m);

x = [];
for i = 1:1:size(x1,1)
    disp(cos(2*pi*f0*i/1000));
    %disp(i);
    
x(i) =  x1(i).*cos(2*pi*f0*i/1000);

end




plot(x);


y = fft(x);
f = (0:length(y)-1)*length(y);
plot(f,abs(y));


z = awgn(x,100);
plot(z);



c = abs(z);
plot(c);
d = lowpass(c,150,1000);
plot(d);
player = audioplayer(d,8192);
play(player);



%load handel.mat

%filename = 'Old_McDonald_noisy_20SNR.wav';
%audiowrite(filename,d,Fs);

nfft = 1024;
f = linspace(0,Fs,nfft);
Y = abs(fft(d,nfft));
figure;
plot(f(10:nfft),Y(10:nfft));
title('freq domain');
xlabel('freq');
ylabel('abs');




nfft = 1024;
f = linspace(0,Fs,nfft);
Y = abs(fft(x,nfft));
figure;
plot(f(10:nfft),Y(10:nfft));
title('freq domain 2');
xlabel('freq');
ylabel('abs');





