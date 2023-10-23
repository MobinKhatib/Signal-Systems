function new_Subject = epochStruct(Subject)
    new_Subject = Subject;
    new_Subject.target_epoch = epoch(Subject.train,Subject.target,Subject.Fs);
    new_Subject.not_target_epoch = epoch(Subject.train,Subject.not_target,Subject.Fs);
    new_Subject.test_epoch = epoch(Subject.test,Subject.test_lcd_indexes,Subject.Fs);
end

function E = epoch(signals,target,Fs)
    E = zeros(size(signals,1),Fs,length(target));
    before = round(Fs * 0.2);
    after = round(Fs * 0.8);
    for i=1:size(signals,1)
        for j=1:length(target)
            index = target(j);
            if index-before > 0 && index+after-1 <= length(signals(i,:))
                E(i,:,j) = signals(i,index-before:index+after-1);
            elseif index-before <= 0
                E(i,before-index+1:end,j) = signals(i,1:index+after-1);
            elseif index+after-1 > length(signals(i,:))
                E(i,end-before-length(signals(i,:))+index:end,j) = signals(i,index-before:end);
            end
        end
    end
end