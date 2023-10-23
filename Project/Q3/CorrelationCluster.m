function outputGroup = CorrelationCluster(InputCorrMat, DistanceMeasure, Select, group, Weight)
    % Select = 0 for WPGMA and Select = 1 for UPGMA
    N = length(InputCorrMat);
    if(nargin < 3)
        Weight = ones(1, N);
        Select = 0;
        group = {};
        for i = 1:N
            group = [group, [i]];
        end
    elseif(nargin < 4)
        Weight = ones(1, N);
        group = {};
        for i = 1:N
            group = [group, [i]];
        end
    end
    
    MinDis = Inf;
    Ind = [];
    for i = 1:N
        for j = 1:N
            dis = InputCorrMat(i, j);
            if(dis ~= 0 && MinDis > dis)
                MinDis = dis;
                Ind = [i j];
            end
        end
    end
    
    a = min(Ind);
    b = max(Ind);
    
    if(InputCorrMat(a,b) > DistanceMeasure)
        outputGroup = group;
        return;
    end
    
    Mat1 = InputCorrMat(b+1 : N, 1 : a-1);
    Mat2 = InputCorrMat(b+1 : N, a+1 : b-1);
    Mat3 = InputCorrMat(b+1 : N, b+1 : N);
    Mat4 = InputCorrMat(a+1 : b-1, 1 : a-1);
    Mat5 = InputCorrMat(a+1 : b-1, a+1 : b-1);
    Mat6 = InputCorrMat(a+1 : b-1, b+1 : N);
    Mat7 = InputCorrMat(1 : a-1, 1 : a-1);
    Mat8 = InputCorrMat(1 : a-1, a+1 : b-1);
    Mat9 = InputCorrMat(1 : a-1, b+1 : N);
    
    NextStepCorrMat = [zeros(N-1, 1), [zeros(1, N-2); [Mat7, Mat8, Mat9; Mat4, Mat5, Mat6; Mat1, Mat2, Mat3]]];
    
    for i = 2:N-1
        if(i-1 < a)
            NextStepCorrMat(1, i) = (InputCorrMat(a, i-1) * Weight(a) + InputCorrMat(b, i-1) * Weight(b)) / (Weight(a) + Weight(b));
        elseif(i-1 >= a && i < b)
            NextStepCorrMat(1, i) = (InputCorrMat(a, i) * Weight(a) + InputCorrMat(b, i) * Weight(b)) / (Weight(a) + Weight(b));
        else
            NextStepCorrMat(1, i) = (InputCorrMat(a, i+1) * Weight(a) + InputCorrMat(b, i+1) * Weight(b)) / (Weight(a) + Weight(b));
        end
        NextStepCorrMat(i, 1) = NextStepCorrMat(1, i);
    end
    
    if(Select)
        NextStepWeight = [Weight(a) + Weight(b), Weight(1 : a-1), Weight(a+1 : b-1),Weight(b+1 : N)];
    else
        NextStepWeight = ones(1,N-1);
    end
    grpA = group(a);
    grpB = group(b);
    
    NextGroup = [group(1:a-1), group(a+1:b-1), group(b+1:N)];
    NextGroup = [[grpA{:}, grpB{:}], NextGroup];
    %outputCorrMat = NextStepCorrMat;
    outputGroup = CorrelationCluster(NextStepCorrMat, DistanceMeasure, Select, NextGroup, NextStepWeight);
end