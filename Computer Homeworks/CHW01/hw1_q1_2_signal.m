clear; clc; close all;
cluster = zeros(500,500);
ran = randi([50 450],2,1000);
cluster(250,250)=1;
cluster(250,249)=1;

h = figure;
axis tight manual 
filename = 'testAnimated.gif';



for i=1:1000
    x = ran(1,i);
    y = ran(2,i);
   % disp('gggggggggggggggggggg');
    %disp(y);
    
    while cluster(y-1,x-1)+cluster(y-1,x)+cluster(y-1,x+1)+cluster(y,x-1)+cluster(y,x+1)+cluster(y+1,x-1)+cluster(y+1,x)+cluster(y+1,x+1)==0
    % disp(x);
    %disp(y);
    
    r = randi(8);
   %disp(r);
        if(r==1 && y~=50)
        y=y-1;
        %M(y,x)=1;
    
         elseif (r==2 && y~=50 && x~= 490)
        y=y-1;
        x=x+1;
        %M(y,x)=1;
        
        elseif (r==3 && x~=490)
        x=x+1;
        %M(y,x)=1;
    
         elseif (r==4 && x~=490 && y~=490)
        x=x+1;
        y=y+1;
        %M(y,x)=1;
          elseif (r==5 && y~=490)
        
        y=y+1;
        %M(y,x)=1;
        
          elseif (r==6 && x~=50 && y~=490)
        x=x-1;
        y=y+1;
        %M(y,x)=1;
          elseif (r==7 && x~=50)
        x=x-1;
       
        %M(y,x)=1;
          elseif (r==8 && x~=50 && y~=50)
        x=x-1;
        y=y-1;
        %M(y,x)=1;
       
        end   
    
    
    
    
    end
    
    cluster(y,x)=1;
    
    imshow(cluster);
  drawnow 
    % Capture the plot as an image 
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if i == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end 




end
