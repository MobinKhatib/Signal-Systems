function HalfBandFrequencyDomain(gd, cutValue)
    if(nargin < 2)
        cutValue = 0;
    end
    temp = gd(1:length(gd)/2 - cutValue);
    n = (1:length(gd)/2 - cutValue) / length(gd) * 2 * pi;
    plot(n, temp);
end