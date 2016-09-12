
%                    Function Name:f_Adaptive_Learning_A

% (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 18-11-2014.

function [LABEL]=f_Adaptive_Learning_A(TEST_X,TR_MDL)

    [No_of_Trails, Dim]=size(TEST_X);

% For each observation compute the UCl and LCL
    for i=1:No_of_Trails;                  
         input_for_pred=TEST_X(i,:); 
         [label]=f_BCI_Classification(input_for_pred,TR_MDL); % Classification Function                  
         LABEL.SVM(i)=label.SVM;

    end
end
