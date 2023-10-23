clear; clc; close all;

load 64channeldata.mat
Fs = 600;
%%
clc; close all;

channel = 1;trial = 1;
figure
    plotFFT(data(channel,:,trial), Fs)
    title(['Channel ',num2str(channel),' trial ', num2str(trial)]);
%%
% Down Sampling:
clc; close all;
[chNum, len, triNum] = size(data);
L = 4;
Fs2 = Fs/L;
downSampled = zeros(chNum, floor(len/L), triNum);
for i = 1:chNum
    for j = 1:triNum
        downSampled(i,:,j) = downSampler(data(i,:,j), L);
    end
end
channel = 1;
trial = 1;
figure
    plotFFT(downSampled(channel,:,trial), Fs)
    title(['DownSampled: Channel ',num2str(channel),' trial ', num2str(trial)]);
%%
% Correlation Matrix:
% a: concatination:
clc; close all;

len = 450;
concated = zeros(chNum, len*triNum);
for i = 1:chNum
    for j = 1:triNum
        stIdx = (j-1)*len+1;
        concated(i, stIdx:j*len) = downSampled(i,:,j);
    end
end
%%
% Calculating the correlation:
cor = zeros(chNum, chNum);

for i = 1:chNum
    for j = 1:i
        cor(i,j) = CorrelationCalculator(concated(i,:), concated(j,:));
        cor(j,i) = cor(i,j);
    end 
end
%%
%Clustering:
clc; close all;

distanceMat = ones(chNum,chNum)-abs(cor)+9*eye(chNum,chNum);
tic
cluster_w = CorrelationCluster(cor, 0.28, 63, 'WPGMA');
toc % 0.84 sec
sum(cluster_w~=0, 'All')
clusterNum_w = max(cluster_w)

%%
% Plot for WPGMA:
clc; close all;

ch_list = {'AFZ','FP1','FP2','AF3','AF4','F7','F3','FZ','F4',...
    'F8','FC5','FC1','FC2','FC6','T7','C3','CZ',...
    'C4','T8','CP5','CP1','CP2','CP6','P7','P3','PZ',...
    'P4','P8','PO3','PO4','O1','O2','FT10','AF7','AF8','F5',...
    'F1','F2','F6','FT7','FC3','FCZ','FC4','FT8','C5','C1',....
    'C2','C6','TP7','CP3','CPZ','CP4','TP8','P5','P1','P2','P6',...
    'PO7','POZ','PO8','OZ','TP9','TP10'};

figure
Values1 = clusterNum_w*ones(1,63)-cluster_w;
H1 = plot_topography(ch_list, Values1, 0, '10-20', 1, 1, 1000);
title('WPGMA');
%%
% Plot for UPGMA:
clc;

tic
cluster_u = CorrelationCluster(cor, 0.28, 63, 'UPGMA');
toc

sum(cluster_u~=0, 'All')
clusterNum_u = max(cluster_u)

figure
Values2 = clusterNum_w*ones(1,63)-cluster_w;
H2 = plot_topography(ch_list, Values2, 0, '10-20', 1, 1, 1000);
title('UPGMA');
%%
% Clustering for 8 channels:

clc; close all; clear all;

load Subject1.mat

[chNum, triNum, len] = size(epoched);

%%
clc;

concated = zeros(chNum, len*triNum);

for i = 1:chNum
    for j = 1:triNum
        stIdx = (j-1)*len+1;
        concated(i, stIdx:j*len) = epoched(i,j,:);
    end
end

%%
cor8 = zeros(chNum, chNum);

for i = 1:chNum
    for j = 1:i
        cor8(i,j) = CorrelationCalculator(concated(i,:), concated(j,:));
        cor8(j,i) = cor8(i,j);
    end 
end

%%

tic
cluster_for8 = CorrelationCluster(cor8, 0.28, chNum, 'WPGMA');
toc

sum(cluster_for8~=0, 'All')
clusterNum8 = max(cluster_for8)


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Functions:

function plotFFT(InputSignal, Fs)
    transformed = fft(InputSignal);
    len = length(InputSignal);
       
    spect = abs(transformed(1:floor(len/2)))/len;
    w = linspace(0, Fs/2, floor(len/2));
    
    plot(w, spect,'LineWidth',2);
    title('FFT output');
    xlim([0, Fs/2])
    grid on
    grid minor
end

function out = downSampler(Signal, L)
    len = length(Signal);
    N = floor(len/L);
    out = zeros(N,1);
    
    for i=1:N
             out(i) = Signal(L*i);  
    end
end


function corr = CorrelationCalculator(input1, input2)
        num = sum(input1.*input2);
        den = sqrt(sum(input1.^2)*sum(input2.^2));
        corr = num/den;
end

function cluster = CorrelationCluster(InputCorrMat, DistanceMeasure, chNum, disType)
    distanceMat = ones(chNum,chNum)-abs(InputCorrMat)+9*eye(chNum,chNum);
    temp_cluster = eye(chNum,chNum);
    
    D_min = min(distanceMat,[], 'All');
    
    while(DistanceMeasure > D_min)
        [Row, Col] = find(distanceMat==D_min);
        [~, Idx] = min([Row(1), Col(1)]);
        
        if(Idx==2)
           t = Row(1);
           Row(1) = Col(1);
           Col(1) = t;
        end
        
        temp_cluster(Row(1),:)=temp_cluster(Row(1),:)+temp_cluster(Col(1),:);
        temp_cluster(Col(1),:) = zeros(1,chNum);
        
        if(isequal(disType, 'UPGMA'))
            distanceMat = UPGMA(temp_cluster, distanceMat, Row(1), Col(1));
        else
            distanceMat = WPGMA(distanceMat, Row(1), Col(1));
        end
        
        D_min = min(distanceMat,[], 'All');
    end
    
    temp_cluster = temp_cluster - tril(temp_cluster, -1);
    temp_cluster = (temp_cluster)~=0;
    
    k = 1;

    for i = 1:chNum
        s = sum(temp_cluster(i,:));
        if(s ~= 0)
            temp(i,:) = k*temp_cluster(i,:);
            k = k +1;
        end
    end
    
    cluster = sum(temp);
end


function newMat = WPGMA(PrevDistance, Row, Col)
    [R, C] = size(PrevDistance);
    
    Max = max([Row(1), Col(1)]);
    Min = min([Row(1), Col(1)]);
    
    for i = 1:R
        if(i==Max)
            temp(i,:) = 9*ones(1,C);
        else
            for j = 1:C
               if((j==Max))
                   temp(i,j) = 9;
               elseif(j==Min)
                   temp(i,j) = (PrevDistance(i,Min)+PrevDistance(i,Max))/2;
               elseif(i==Min)
                   temp(i,j) = (PrevDistance(Min,j)+PrevDistance(Max,j))/2;
               else
                   temp(i,j) = PrevDistance(i,j);
               end
            end
        end
    end
    newMat = temp;
end


function newMat = UPGMA(cluster, PrevDistance, Row, Col)
    check = cluster - tril(cluster, -1);
    check = (check)~=0;
    
    w = sum(transpose(check));
    [R, C] = size(PrevDistance);
    
    Max = max([Row(1), Col(1)]);
    Min = min([Row(1), Col(1)]);
    
    for i = 1:R
        if(i==Max)
            temp(i,:) = 9*ones(1,C);
        else
            for j = 1:C
               if((j==Max))
                   temp(i,j) = 9;
               elseif(j==Min)
                   temp(i,j) = (w(Min)*PrevDistance(i,Min)+w(Max)*PrevDistance(i,Max))/(w(Min)+w(Max));
               elseif(i==Min)
                   temp(i,j) = (w(Min)*PrevDistance(Min,j)+w(Max)*PrevDistance(Max,j))/(w(Min)+w(Max));
               else
                   temp(i,j) = PrevDistance(i,j);
               end
            end
        end
    end
    newMat = temp;
end
function epoched = epoching(InputSignal,BackwardSamples,ForwardSamples,StimuliOnset)
    Fs = 3/(InputSignal(1,6)-InputSignal(1,3));
    
    BckIdx = floor(BackwardSamples*Fs);
    ForIdx = floor(ForwardSamples*Fs);
    N = length(StimuliOnset);
    
    epoched = zeros(8, N, BckIdx+ForIdx);
    
    for i = 1:N
        startIdx = StimuliOnset(i)-BckIdx;
        endIdx = StimuliOnset(i)+ForIdx-1;
        
        epoched(:,i,:) = InputSignal(2:9, startIdx:endIdx);  
    end
end