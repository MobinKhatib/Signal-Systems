function new_Subject = reduceSampleRateStruct(Subject,new_Fs)
    
    train_Fs = Subject.train_Fs;
    test_Fs = Subject.test_Fs;
    train_fratio = floor(train_Fs/new_Fs);
    test_fratio = floor(test_Fs/new_Fs);

    new_Subject.train = Subject.train(:,1:train_fratio:end);
    new_Subject.test = Subject.test(:,1:test_fratio:end);
    new_Subject.Fs = new_Fs;
end