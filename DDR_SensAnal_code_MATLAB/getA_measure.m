% This function takes two input arguments: vector x0 and vector x1. 
% This function compares all the elements in x0 to all the elements in x1,
% in order to compute the A-measure. 
% This function returns two values: 
% (1) the A_measure (which has a value between 0 and 1) and
% (2) the scaled_A_measure (which omits direction and has a value between 0.5 and 1). 

function [A_measure, scaled_A_measure] = getA_measure(x0, x1)

    % Compute the A_measure
    A_measure = 0;
    for i = 1:length(x0)
        for j = 1:length(x1)
            if(x0(i)>x1(j))
                A_measure = A_measure + 1; 
            elseif(x0(i)==x1(j))
                A_measure = A_measure + 0.5; 
            elseif(x0(i)<x1(j))
                A_measure = A_measure + 0; 
            end
        end
    end 
    A_measure = A_measure/(length(x0)*length(x1));

    % Compute the scaled_A_measure
    if(A_measure>=0.5)
        scaled_A_measure = A_measure;
    else
        scaled_A_measure = 1-A_measure;
    end
    
end
