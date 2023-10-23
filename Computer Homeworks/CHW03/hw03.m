%% 3.1.1
clc;
clear;
load data;
data = data(5*250+1:87500-5*250, :);

%% 3.1.2
clc;
clear;

load data;
data = data(5*250+1:87500-5*250, :);
data = zscore(data);
rest = zeros(20 * 250, 19);
task = zeros(40 * 250, 19);

for i = 0:4
    task = task + data(i*60*250 + 1 : i*60*250 + 40*250, :);
    rest = rest + data(i*60*250 + 40*250 + 1 : (i+1)*60*250, :);
end
task = task + data(5*60*250 + 1 : 5*60*250 + 40*250, :);
rest = rest / 5;
task = task / 6;

%% 3.1.3
clc;
clear;

load data;
data = data(5*250+1:87500-5*250, :);
data = zscore(data);
rest = zeros(20 * 250, 19); 
task = zeros(40 * 250, 19);

for i = 0:4
    task = task + data(i*60*250 + 1 : i*60*250 + 40*250, :);
    rest = rest + data(i*60*250 + 40*250 + 1 : (i+1)*60*250, :);
end
task = task + data(5*60*250 + 1 : 5*60*250 + 40*250, :);
rest = rest / 5;
task = task / 6;

Prest = 1 / length(rest) * sum(rest.^2);
Ptask = 1 / length(task) * sum(task.^2);

%% 3.1.4
clc;
clear;

load data;
data = data(5*250+1:87500-5*250, :);
data = zscore(data);
rest = zeros(20 * 250, 19);
task = zeros(40 * 250, 19);

for i = 0:4
    task = task + data(i*60*250 + 1 : i*60*250 + 40*250, :);
    rest = rest + data(i*60*250 + 40*250 + 1 : (i+1)*60*250, :);
end
task = task + data(5*60*250 + 1 : 5*60*250 + 40*250, :);
rest = rest / 5;
task = task / 6;

Prest = 1 / length(rest) * sum(rest.^2);
Ptask = 1 / length(task) * sum(task.^2);

channel_title = {'FP1','FP2','F7','F3','FZ','F4','F8','T7','C3','CZ','C4','T8','P7','P3','PZ','P4','P8','O1','O2'};
load Standard_10-20_81ch.mat;

subplot(1,2,1);
plot_topography(channel_title, Ptask);
title('Task');
subplot(1,2,2);
plot_topography(channel_title, Prest);
title('Rest');


%% 3.2.1
clc;
clear;

load eye.mat;

%% 3.2.2
clc;
clear;

load eye.mat;
cnt = 0;
for i = 1:length(E) / 500 - 1
    e = E(i*500+1 : (i+1)*500);
    m = max(e);
    if m > 2.5
        cnt = cnt + 1;
    end
end
disp(cnt);

%% 3.2.3
clc;
clear;
load eye.mat;

blink = [];
for i = 1:length(E) / 500 - 1
    e = E(i*500+1 : (i+1)*500);
    m = max(e);
    if m > 2.5
       ind = find(e == m);
       blink = [blink, i*500+ind];
    end
end
plot(E);
hold on;
plot(blink, E(blink), '.');
hold off;
disp(length(blink));

%% Functions

function output_image = cluster(input_image,x,y,k,n) % x and y are initialized cluster centers.
    s = size(input_image);
    output_image = zeros(s(1), s(2));  
    for a = 1:s(1)
        for b = 1:s(2)
            min_dis = inf;
            for i = 1:k
                centroid = double(input_image(x(i), y(i), :));
                image = double(input_image(a, b, :));
                dis = sum((centroid - image).^2);
                if min_dis > dis
                    min_dis = dis;
                    output_image(a, b) = i;
                end
            end
        end
    end
    
    sum_cluster = zeros(k, 2);
    num = zeros(k, 1);
    
    for a = 1:s(1)
        for b = 1:s(2)
            ind = output_image(a, b);
            sum_cluster(ind, 1) = sum_cluster(ind, 1) + a;
            sum_cluster(ind, 2) = sum_cluster(ind, 2) + b;
            num(ind) = num(ind) + 1;
        end
    end
    
    flag = 0;
    for i = 1:k
        temp_x = round(sum_cluster(i, 1) / num(i));
        temp_y = round(sum_cluster(i, 2) / num(i));
        if (x(i) ~= temp_x) || (y(i) ~= temp_y)
            flag = 1;
        end
        x(i) = temp_x;
        y(i) = temp_y;
    end
    
    if flag == 0 || n == 0
        return;
    end
    cluster(input_image, x, y, k, n-1);
end

function output_image = otsu(input_image)
    intensity = zeros(1, 256);
    s = size(input_image);
    number_of_pixels = s(1) * s(2);
    for i = 1:s(1)
        for j = 1:s(2)
            ind = input_image(i, j);
            intensity(ind + 1) = intensity(ind + 1) + 1;
        end
    end
    
    max_var = 0;
    ind = 0;
    for t = 1:255
        Wb = sum(intensity(1:t)) / number_of_pixels;
        Wf = sum(intensity(t+1:256)) / number_of_pixels;
        ub = sum(intensity(1:t) .* (0:t-1)) / sum(intensity(1:t));
        uf = sum(intensity(t+1:256) .* (t:255)) / sum(intensity(t+1:256));
        var = Wb * Wf * (ub - uf)^2;
        if max_var < var
            max_var = var;
            ind = t;
        end
    end
    output_image = input_image > (ind-1);
end

function detector(input_image)
    tresh = 2;
    peopleDetector = vision.PeopleDetector('UprightPeople_96x48','ClassificationThreshold',tresh,'MaxSize',[150,150]);
    [bboxes,scores] = peopleDetector(input_image);
    if ~isempty(bboxes)
        output_image = insertObjectAnnotation(input_image,'rectangle',bboxes,scores);
    else
        output_image = input_image;
    end
    imshow(output_image);
end
