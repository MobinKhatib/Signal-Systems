clear; clc; close all;

fileName = 'sound2.wav';

[x,Fs] = audioread(fileName);
result1 = sampleUp(x,3);
result2 = hop(result1,5);
figure(1)
plot(result2);
figure(2)
plot(x);

function output1 = hop(x,M)
        output1 =[];
        
    for i =M:M:max(size(x))
         
        output1 = [output1 , x(i)];
    
    end

end



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