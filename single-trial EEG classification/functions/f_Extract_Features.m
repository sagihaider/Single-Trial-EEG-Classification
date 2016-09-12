function [X_feature_left, X_feature_right]=f_Extract_Features(Data, time_point, Samp_Pts, No_Trials, Total_Trials,No_of_Components)

% This code is for extracting the features from TRAINING data

 % (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 03-Oct-2014

% Input:
        %  Data= Data
        %  time_point=time window (3 Sec) i.e 750 Observation
        %  Samp_Pts: Sampleing Points in each trial
        %  No_Trials: No of Trials for each class
        %  Total_Trials: Total No of Trials in Data
        %  No_of_Components: NO of Components to be extracted             
        % 
% Output:
        % X_feature_left: Log Variance feature of each trials of left
        % X_feature_right: Log Variance feature of each trials of right

len_Data=length(Data);
len_right_Data=len_Data/2;

Left_Data=Data(:,1:Samp_Pts);
for i=2:No_Trials
    Temp=Data(:,(i-1)*Samp_Pts+1:i*Samp_Pts);
    Left_Data=cat(3,Left_Data,Temp);
end


Right_Data=Data(:,len_right_Data+1:len_right_Data+Samp_Pts);
for i=No_Trials+2:Total_Trials
    Temp=Data(:,(i-1)*Samp_Pts+1:i*Samp_Pts);
    Right_Data=cat(3,Right_Data,Temp);
end

Left_tr=Left_Data(:,:,:);
Right_tr=Right_Data(:,:,:);

for i=1:No_Trials
    for j=1:No_of_Components
       Temp=var(Left_tr(j,:,i));
       X_feature_left(i,j)=log(Temp);
       
       Temp=var(Right_tr(j,:,i));
       X_feature_right(i,j)=log(Temp);
    end
end

end