function new_Subject = bandpassStruct(Subject,fpass)
    disp('please wait for filtering...');

    train = Subject.train;
    test = Subject.test;
    train_time = train(1,:);
    test_time = test(1,:);
    train_Fs = floor(length(train_time)/(train_time(end)-train_time(1)));
    test_Fs = floor(length(test_time)/(test_time(end)-test_time(1)));
    
    for i=2:9
        train(i,:) = train(i,:) - mean(train(i,:));
        test(i,:) = test(i,:) - mean(test(i,:));
        test(i,:) = detrend(test(i,:));
        train(i,:) =  bandpass(train(i,:),fpass,train_Fs);
        test(i,:) =  bandpass(test(i,:),fpass,test_Fs);
    end
    
    new_Subject.train = train;
    new_Subject.test = test;
    new_Subject.train_Fs = train_Fs;
    new_Subject.test_Fs = test_Fs;
    clc;
end