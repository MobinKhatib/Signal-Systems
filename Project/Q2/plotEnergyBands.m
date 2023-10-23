function plotEnergyBands(input_signal, Fs, window, lastFreq)
    sFreq  = 0;
%     window = 500;
%     lastFreq = 10000;
    power = zeros(1,floor(lastFreq/window));
    for ii=1:floor(lastFreq/window)
        power(ii) = bandpower(input_signal,Fs,[sFreq sFreq+window-1]);
        sFreq = sFreq + window;
    end
    tt = (0:length(power)-1) * window;
    bar(tt,power); grid minor;
end