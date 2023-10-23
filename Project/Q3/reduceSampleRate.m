function new_signal = reduceSampleRate(signal, Fs, new_Fs)
    if nargin < 3
        fratio = Fs;
    else
        fratio = floor(Fs/new_Fs);
    end
    new_signal = signal(:, 1:fratio:end);
end
