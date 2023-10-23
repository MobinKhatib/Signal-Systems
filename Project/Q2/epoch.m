function E = epoch(signals,target,Fs)
    E = zeros(size(signals,1),Fs,sum(target));
    before = round(Fs * 0.2);
    after = round(Fs * 0.8);
    indexes = find(target);
    for i=1:size(signals,1)
        for j=1:sum(target)
            index = indexes(j);
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