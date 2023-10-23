function [Model,X_train,y_train] = learn(Subject_features,n,mode)
    X_train = Subject_features.feature;
    X_train = X_train(1:n,:);
    y_train = Subject_features.label;
%     m = n - size(X_train,1);
%     r = randi(m,1,m);
    y_train = y_train(1:n);
    i = y_train == 0; y_train(i) = 2;
    if mode == 1
        Model = fitcsvm(X_train,y_train);
    else
        Model = fitcdiscr(X_train,y_train);
    end
end