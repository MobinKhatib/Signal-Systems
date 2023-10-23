clear;
clc;

load 64channeldata.mat;

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

group = CorrelationCluster(distanceMatrix, 0.28, 1); % for Select = 0 -> 0.5 // for Select = 1 -> 0.28
cluster = zeros(1, length(corr));

for i = 1:length(group)
    temp = group(i);
    for j = 1:length(temp)
        cluster(temp{j}) = i;
    end
end

ch_list = {'AFZ','FP1','FP2','AF3','AF4','F7','F3','FZ','F4','F8','FC5','FC1','FC2','FC6','T7','C3','CZ',...
    'C4','T8','CP5','CP1','CP2','CP6','P7','P3','PZ','P4','P8','PO3','PO4','O1','O2','FT10','AF7','AF8','F5',...
    'F1','F2','F6','FT7','FC3','FCZ','FC4','FT8','C5','C1','C2','C6','TP7','CP3','CPZ','CP4','TP8','P5','P1','P2','P6',...
    'PO7','POZ','PO8','OZ','TP9','TP10'};
plot_topography(ch_list, length(group) - cluster);
