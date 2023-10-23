clear; clc; close all;

fileName = 'Q1.wav';
M = 10;
[x,Fs] = audioread(fileName);

answer2 = hop(x,M);
%sound(audioread(fileName));
sound(answer2);
function output = hop(x,M)
        output =[];
    for i =M:M:size(x)
    
        output = [output , x(i)];
    
    end
disp(output);
end