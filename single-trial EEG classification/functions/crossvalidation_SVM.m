function indices = crossvalidation_SVM(y, nfold)
    %# stratified n-fold cros-validation
    %#indices = crossvalind('Kfold', y, nfold);  %# Bioinformatics toolbox
    cv = cvpartition(y, 'kfold',nfold);          %# Statistics toolbox
    indices = zeros(size(y));
    for i=1:nfold
        indices(cv.test(i)) = i;
    end
end