function gd = groupdelay(h, N)
    n = 0:length(h)-1;
    num = fft(n .* h, N);
    den = fft(h, N);
    gd = real(num ./ den);
end