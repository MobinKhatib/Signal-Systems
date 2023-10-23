function new_Subject = IndexExtraction(Subject)

train = Subject.train;

train_lcd_trigger = double(getTrigger(train(10,:)));
train_detect_trigger = double(getTrigger(train(11,:)));
train_lcd_indexes = find(train_lcd_trigger);
train_target = find(train_detect_trigger);
train_not_target = setdiff(train_lcd_indexes,train_target);


test = Subject.test;

test_lcd_trigger = double(getTrigger(test(10,:)));
test_lcd_indexes = find(test_lcd_trigger);

new_Subject.train_time = train(1,:);
new_Subject.test_time = test(1,:);

new_Subject.train = train(2:9,:);
new_Subject.test = test(2:9,:);

new_Subject.target = train_target;
new_Subject.target_values = train(10,train_target);
new_Subject.not_target = train_not_target;
new_Subject.not_target_values = train(11,train_not_target);
new_Subject.test_lcd_indexes = test_lcd_indexes;
new_Subject.test_lcd_values = test(10,test_lcd_indexes);

new_Subject.Fs = Subject.Fs;
end