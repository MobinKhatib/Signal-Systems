clear; clc; close all;

fileName = 'Q1.wav';

%sound(audioread(fileName));
%[y,Fs] = audioread(fileName);
answer = audioReadd(fileName);




function output = audioReadd(fileName)
output = [];
[y,Fs] = audioread(fileName);

for i = 1401:1:1410
        output = [output , y(i)];
end


end


