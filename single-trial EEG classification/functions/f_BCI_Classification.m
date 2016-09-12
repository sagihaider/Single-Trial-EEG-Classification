function [label]=f_BCI_Classification(x,TR_MDL)

% disp('####      Classifying the Features for SVM ####  ' );
label.SVM=svmclassify(TR_MDL.svm_mdls,x);
end