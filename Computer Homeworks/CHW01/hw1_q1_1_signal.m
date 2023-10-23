clear; clc; close all;
M = zeros(500,500);
x = 250;
y = 250;
M(y,x)=1;
for i = 1:10000
r = randi(8);
   
    if(r==1)
        y=y-1;
        M(y,x)=1;
    
    elseif (r==2)
        y=y-1;
        x=x+1;
        M(y,x)=1;
        
     elseif (r==3)
        x=x+1;
        M(y,x)=1;
    
         elseif (r==4)
        x=x+1;
        y=y+1;
        M(y,x)=1;
          elseif (r==5)
        
        y=y+1;
        M(y,x)=1;
        
          elseif (r==6)
        x=x-1;
        y=y+1;
        M(y,x)=1;
          elseif (r==7)
        x=x-1;
       
        M(y,x)=1;
          elseif (r==8)
        x=x-1;
        y=y-1;
        M(y,x)=1;
        
        
        
     end   
    
    
end
imshow(M);
