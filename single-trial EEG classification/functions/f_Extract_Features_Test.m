function [TEST_DB]=f_Extract_Features_Test(test,time_point,Samp_Pts,Total_Trials,No_of_Components )

% This code is for extracting the features from TESTING data

 % (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 03-Oct-2014

% Input:
        %  test= Data TESTING
        %  time_point=time window (3 Sec) i.e 750 Observation
        %  Samp_Pts: Sampling Points in each trial
        %  Total_Trials: Total No of Trials in Data
        %  No_of_Components: NO of Components to be extracted             
        % 
% Output:
        % TEST_DB: Testing Data Features (Log Variance)

Test_Db=test(:,1:Samp_Pts);
for i=2:Total_Trials
    Temp=test(:,(i-1)*Samp_Pts+1:i*Samp_Pts);
    Test_Db=cat(3,Test_Db,Temp);
end

TEST=Test_Db(:,:,:);


for i=1:Total_Trials
    for j=1:No_of_Components
       Temp=var(TEST(j,:,i));
       TEST_DB(i,j)=log(Temp);    
    end
end