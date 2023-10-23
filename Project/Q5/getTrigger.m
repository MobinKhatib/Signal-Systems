function trigger = getTrigger(signal)
    temp1 = cat(2,signal,0) > 0;
    temp2 = cat(2,0,signal) > 0;
    temp = [temp1;temp2];
    trigger = xor(temp(1,:),temp(2,:)) & temp(1,:);
    trigger = trigger(1:end-1);
end