clear;
clc;

load epoch8channel.mat;

%Arranged = reshape(data, [size(data, 1), size(data, 2) * size(data, 3)]);
%%{
Arranged = zeros(size(data, 1), size(data, 2) * size(data, 3));
for i = 1:size(data, 1)
    temp = data(i, :, :);
    for j = 1:size(data, 3)
        Arranged(i, 1 + size(data, 2) * (j-1) : size(data, 2) * j) = temp(1, :, j);
    end
end
%}
reduced = reduceSampleRate(Arranged, 600, 120);
corr = corrcoef(reduced');
distanceMatrix = 1 - corr;

group = CorrelationCluster(distanceMatrix, 0.4, 1); % for Select = 0 and Select = 1 -> 0.4
cluster = zeros(1, length(corr));

for i = 1:length(group)
    temp = group(i);
    for j = 1:length(temp)
        cluster(temp{j}) = i;
    end
end

ch_list = {'FZ', 'CZ', 'PZ', 'P4', 'P3', 'OZ', 'PO7', 'PO8'};
plot_topography(ch_list, length(group) - cluster);