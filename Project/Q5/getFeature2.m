function new_Subject = getFeature2(Subject,mode)
    if mode == 1
        new_Subject = Subject;
    end
    target_epoch = Subject.target_epoch;
    not_target_epoch = Subject.not_target_epoch;
    test_epoch = Subject.test_epoch;
    
    target_feature = squeeze(target_epoch(1,:,:));
    %target_label = Subject.target_values;
    for i = 2:size(target_epoch,1)
         target_feature = cat(1,target_feature,squeeze(target_epoch(i,:,:)));
         %target_label = cat(2,target_label,Subject.target_values);
    end
    
    not_target_feature = squeeze(not_target_epoch(1,:,:));
    %not_target_label = Subject.not_target_values;
    for i = 2:size(not_target_epoch,1)
        not_target_feature = cat(1,not_target_feature,squeeze(not_target_epoch(i,:,:)));
        %not_target_label = cat(2,not_target_label,Subject.not_target_values);
    end
    
    test_feature = squeeze(test_epoch(1,:,:));
    %test_label = Subject.test_lcd_values;
    for i = 2:size(test_epoch,1)
         test_feature = cat(1,test_feature,squeeze(test_epoch(i,:,:)));
         %test_label = cat(2,test_label,Subject.test_lcd_values);
    end
    
    new_Subject.target_feature = target_feature';
    % new_Subject.target_label = target_label';
    new_Subject.not_target_feature = not_target_feature';
    % new_Subject.not_target_label = not_target_label';
    new_Subject.test_feature = test_feature';
    % new_Subject.test_label = test_label';
    
    feature = cat(1,new_Subject.target_feature,new_Subject.not_target_feature);
    label_1 = ones(size(new_Subject.target_feature,1),1);
    label_0 = zeros(size(new_Subject.not_target_feature,1),1);
    label = cat(1,label_1,label_0);
    new_Subject.feature = feature;
    new_Subject.label = label;
end