function acc = Cross_Validation_Haider(y, X, CASE, opts, nfold, indices)

% (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 27-Jan-2014

% Input:
%       y: Labels
%       X:  Input data
%    CASE: The name of the classifier to use SVM, LDA, NN

% Output:
%       acc:  Cross-Validation accuracy.
if nargin < 4, opts = ''; end
if nargin < 5, nfold = 10; end
if nargin < 6, indices = crossvalidation_SVM(y, nfold); end

%# N-fold cross-validation testing
acc = zeros(nfold,1);
for i=1:nfold
    testIdx = (indices == i); trainIdx = ~testIdx;
    
    switch CASE
        case 'SVM'
            mdl = fitcsvm(X(trainIdx,:),y(trainIdx)); %  SVM Classifier Training
            accc=predict(mdl, X(testIdx,:));  % SVM Classification Testing
        case 'LDA'
            W = f_LDAsimple(X(:,trainIdx)',y(trainIdx)');
            % Calulcate linear scores for training data
            L = [ones(length(X(:,testIdx)),1), X(:,testIdx)'] * W';
            
            % Calculate class probabilities
            P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);
            
            for j=1:length(P)
                if (P(j,1)>=0.50)
                    accc(1,j)=0;
                else
                    accc(1,j)=1;
                end
            end
            
        case 'kNN'
            mdl = ClassificationKNN.fit(X(trainIdx,:),y(trainIdx),'NumNeighbors',5);
            accc=predict(mdl, X(testIdx,:)); % kNN Classification Tetsing
            
        otherwise
            return
    end
    [acc(i)] =1-sum((accc-y(testIdx)).^2)/length(accc);
end
acc = mean(acc);    %# average accuracy
end


