function corrected_filtered = zphasefilter(h, x)
    M = length(h);
    N = length(x);
    gd = groupdelay(h, M);
    filtered = conv(h,x);
    corrected_filtered = filtered(gd(1) + 1:gd(1) + N); % gd for linear phase is constant
end