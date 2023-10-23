clear; clc; close all;


A = randi(2, 500) - 1;
%A = randi([0 1], 100 , 100);
h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'testAnimated.gif';
for n = 1:1:100
    % Draw plot for y = x.^n
    %x = 0:0.01:1;
    %y = x.^n;
    %plot(x,y) 
    kernel = [1 1 1;...
          1 0 1;...
          1 1 1];


B = conv2(A,kernel,'same');
A = double((A & B == 2) | B == 3);

imshow(A);
    
    
    
    
    drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if n == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end 
end