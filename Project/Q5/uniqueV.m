function u = uniqueV(vector)
    u = vector(1);
    counter = 1;
    for i=2:length(vector)
        if u(counter) ~= vector(i)
            counter = counter + 1;
            u(counter) = vector(i);
        end
    end
end