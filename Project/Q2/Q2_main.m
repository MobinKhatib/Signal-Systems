%% ======================= Part 2.1: Loading Data =========================
clear; clc; close all;

load SubjectData1.mat;

init_signal = train;

init_time = init_signal(1,:);
init_signals = init_signal(2:9,:);
init_trigger1 = init_signal(10,:);
init_trigger2 = init_signal(11,:);
Fs = length(init_time)/(init_time(end)-init_time(1));

%% ================== Part 2.2: Filter and Ploting Data ===================
Hd = bpf1to30Hz;
filt = Hd.Numerator;

n = 8;
times = cell(1,n);
signals = cell(1,n);
filterdSignls = cell(1,n);
for i = 1:n
    times{i} = init_time;
    signals{i} = init_signals(i,:);
    figure;
    subplot(311); HalfBandFFT(signals{i}, Fs, 0);
    subplot(312); plotEnergyBands(signals{i}, Fs, 10, 120);
    temp = signals{i} - mean(signals{i});
    filterdSignls{i} = conv(temp,filt,'same');
    subplot(313); HalfBandFFT(filterdSignls{i}, Fs, 0);
end

T = {'1', '2', '3', '4', '5', '6', '7', '8'};

Titles = {'Fz', 'Cz', 'Pz', 'P4', 'P3', 'Oz', 'Po7', 'Po8'};
plotSignals(times,signals,T,[4,2]);

plotSignals(times,filterdSignls,T,[4,2]);

%% ============== Part 2.3: Reduce the sampling frequency =================
close all
Fs_new = 64; % Hz
fratio = floor(Fs/Fs_new);
signals_new = cell(1,n);
times_new = cell(1,n);
for i = 1:n
    signals_new{i} = signals{i}(1:fratio:end);
    times_new{i} = times{i}(1:fratio:end);
end
trigger = init_trigger1(1:fratio:end);

T = {'1', '2', '3', '4', '5', '6', '7', '8'};
plotSignals(times_new,signals_new,T,[4,2]);

%% =========================== Part 2.4 epoching ==========================

trigger_new = double(getTrigger(trigger));
signal = zeros(8,length(signals_new{1}));
for i=1:8
    signal(i,:) = signals_new{i};
end
E = epoch(signal,trigger_new,Fs_new);
%% ================================= END ==================================