function [Theta1, Theta2, train_pred, test_pred, Result] = ...
    NeuralNetworkLearnig(train,y_train,test,test_value,...
    input_layer_size,hidden_layer_size,num_labels,iter)

% ============================ generate weights ===========================
    epsilon = 0.12;
    initial_Theta1 = rand(hidden_layer_size, input_layer_size + 1) * 2 * epsilon - epsilon;
    initial_Theta2 = rand(num_labels, hidden_layer_size + 1) * 2 * epsilon - epsilon;

    initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
    
% ======================== Training Neural Networks =======================
clc
lambda = 1;

costFunction = @(p) nnCostFunction(p, input_layer_size, ...
                    hidden_layer_size, num_labels, train, y_train, lambda);

options = optimset('MaxIter', iter);
[nn_params, ~] = fmincg(costFunction, initial_nn_params, options);

% reshaping weigths
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                            hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                            num_labels, (hidden_layer_size + 1));
                        
% ========================== check Neural Network =========================
clc
train_pred = recognise(train, Theta1, Theta2);

precision = mean(double(train_pred == y_train)) * 100;
fprintf('Correct recognition: %.2f%%\n\n', precision);

test_pred = recognise(test, Theta1, Theta2);

i = test_pred == 1;
num = test_value(i);

LCD = ['A','B','C','D','E','F';...
    'G','H','I','G','K','L';...
    'M','N','O','P','Q','R';...
    'S','T','U','V','W','X';...
    'Y','Z','0','1','2','3';...
    '4','5','6','7','8','9']';

Result = LCD(num);
end