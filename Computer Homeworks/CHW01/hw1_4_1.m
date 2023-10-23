clear; clc; close all;
Fs = 44100;
N = 10;

%notess= ["G", "G", "A#", "D#", "D"];
 notess =  ["G", "G", "A#", "D#", "D", ...
 "G", "G", "A#", "D", "C", ...
 "G", "G", "G", "G", "G", "G#", ...
 "G#", "G#", "G#", "G#", "G", "G"];

 noteDurationss = [330, 330, 490, 490, 790, ...
 330, 330, 490, 490, 750, ...
 330, 330, 330, 490, 490, 700, ...
 330, 330, 330, 490, 490, 750];

 %noteDurationss = [330, 330, 490, 490, 790];

 

alpha = 0.97;



%function song = mixerr(notes,noteDurations)

returnedFreq =  noteFreq(notess);
newPiece=[];
for i= 1:1:22
newPiece = [newPiece , generateNote(returnedFreq(i),noteDurationss(i),alpha)];
end
%end
player = audioplayer(newPiece,Fs);
play(player);

function outVector = generateNote(freq, duration , alpha )
%N = [];
Fs = 44100;
%for i =1:1:5
 %   disp(floor(Fs ./ freq(i)));
    N = floor(Fs ./ freq);
%end
%disp(N);
%outVector = [0];
  %x = rand(1,N,'double');
   x=-1 + (2) .* rand(1,N);
 % x = randi([-1,1],1,N,'double');
    Y = zeros(1,floor(duration.*0.25*N));
 % tem =Y+ [x;zeros(1,5)];
for i = 1:1:N
   
    Y(i) = x(i);
    
end
 
for j=(N+2):1:(duration.*0.25*N)

    Y(j) = 0.97.*(Y(j-N)+Y(j-N-1))./2;

end

outVector = Y;
disp('x');

disp(x);
disp('Y');
disp(Y);
%}
end




function outfreq = noteFreq (note)

outfreq = [];
%disp(note(1));
for i = 1:1:22
switch note(i)
    case "G"
        outfreq = [outfreq,392];
    case "A#"
        outfreq = [outfreq,466];
    case "D"
        outfreq = [outfreq,293];
    case "D#"
        outfreq = [outfreq,311];
     case "C"
        outfreq = [outfreq,261];
        case "G#"
        outfreq = [outfreq,415];
 
    otherwise
        disp('other value')
end

end

end


