function [label]=f_BCI_Classification(x,model)

% disp('####      Classifying the Features for SVM ####  ' );
label.SVM=predict(model,x);
end