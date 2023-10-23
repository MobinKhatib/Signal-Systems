clear; clc; close all;
Fs = 44100;
N = 10;




notess =  ["F5", "F5", "F5", "C5", "D5", ...
 "D5", "C5", "A5", "A5", "G5", ...
 "G5", "F5"];
dure = 50 * 3;
 noteDurationss = [dure, dure, dure, dure, dure, ...
 dure, 2*dure, dure, dure, dure, ...
 dure,4*dure];

song =  digitalPiano(notess , noteDurationss);
player = audioplayer(song,Fs);
play(player);
%load handel.mat

%filename = 'Old_McDonald.wav';
%audiowrite(filename,song,Fs);

%{
y = song;
N = size(y,2);
Y = fft(y,N);
F = ((0:1/N:1-1/N)*Fs).';
magnitudeY = abs(Y);        % Magnitude of the FFT
phaseY = unwrap(angle(Y));  % Phase of the FFT
dB_mag=mag2db(magnitudeY);
subplot(2,1,1);
plot(F(1:end/2),dB_mag(1:end/2));
title('Magnitude response of signal');
ylabel('Magnitude(dB)');
 
subplot(2,1,2);
plot(F(1:end/2),phaseY(1:end/2));
title('Phase response of signal');
xlabel('Frequency in kHz')
ylabel('radians');

%}
%t = 1:0.1:100;
%x = t;
%fourie = fft(x);
%plot(fourie);

%plot(song);

player = audioplayer(song,Fs);
play(player);


nfft = 1024;
ffff = linspace(0,Fs,nfft);
Y = abs(fft(song,nfft));
figure;
plot(ffff(10:nfft),Y(10:nfft));
title('freq domain');
xlabel('freq');
ylabel('abs');


clear y Fs;


function finalSong  = digitalPiano(notess , noteDurationss)

alpha = 0.97;

returnedFreq =  noteFreq(notess);
newPiece=[];
for i= 1:1:12
newPiece = [newPiece , generateNote(returnedFreq(i),noteDurationss(i),alpha)];
end

newPiece2=[];
for i= 1:1:12
newPiece2 = [newPiece2 , generateNote2(returnedFreq(i),noteDurationss(i),alpha)];
end



%end
%player = audioplayer(newPiece,Fs);
%play(player);
finalSong = newPiece2;

end
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
%disp('x');

%disp(x);
%disp('Y');
%disp(Y);
%}
end



function outVector = generateNote2(freq, duration , alpha )
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


Z = zeros(1,floor(duration.*0.25*N));
disp(floor(duration.*0.25*N));
for i = 1:1:floor(duration.*0.25*N)/4
        
        Z(i) = Y(i);
        Z(i+500)=0.7*Y(i);
        Z(i+1000)=0.6*Y(i);
        Z(i+1500)=0.5*Y(i);
        

end

%for i = (floor(duration.*0.25*N))/2:1:floor(duration.*0.25*N)
 %       disp(floor(duration.*0.25*N));
  %      Z(i) = Y(i-10);

%end


outVector = Z;
%disp('x');

%disp(x);
%disp('Y');
%disp(Y);
%}
end










function outfreq = noteFreq (note)

outfreq = [];
%disp(note(1));
for i = 1:1:12
switch note(i)
    case "A3"
        outfreq = [outfreq,220];
    case "B3"
        outfreq = [outfreq,264.94];
    case "C3"
        outfreq = [outfreq,130.81];
    case "D3"
        outfreq = [outfreq,146.83];
     case "E3"
        outfreq = [outfreq,164.81];
        case "F3"
        outfreq = [outfreq,174.61];
 case "G3"
        outfreq = [outfreq,196];
 
    
    
    
    
    
    
    case "A4"
        outfreq = [outfreq,440];
    case "B4"
        outfreq = [outfreq,493.88];
    case "C4"
        outfreq = [outfreq,261.63];
    case "D4"
        outfreq = [outfreq,293.66];
     case "E4"
        outfreq = [outfreq,329.63];
        case "F4"
        outfreq = [outfreq,349.23];
 case "G4"
        outfreq = [outfreq,392];
 
        
        
        
        case "A5"
        outfreq = [outfreq,880];
    case "B5"
        outfreq = [outfreq,987];
    case "C5"
        outfreq = [outfreq,523];
    case "D5"
        outfreq = [outfreq,587];
     case "E5"
        outfreq = [outfreq,659];
        case "F5"
        outfreq = [outfreq,698];
 case "G5"
        outfreq = [outfreq,783];
 
        
        
    otherwise
        disp('other value')
end

end

end