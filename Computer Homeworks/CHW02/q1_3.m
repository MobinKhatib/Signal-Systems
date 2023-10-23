clear; clc; close all;

fileName = 'C6.wav';
w = audioread(fileName);
figure(1);
%sound(w);
M = 16;
%figure(1)
plot(w);
[x,Fs] = audioread(fileName);
answer3 = sampleUp(x,M);

figure(2);
plot(answer3);
%sound(answer3);
function output = sampleUp(x,M)
output=[];
sz=max(size(x));
    newSize =(sz-1)*(M-1)+sz;
    s = newSize;
    
    output =zeros(1,s);
    j=1;
    for i = M:M:s
        
        output(i) = x(j);
        j=j+1;
    
    end


end