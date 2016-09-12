function [LHH, RHH]=f_Reshape_Data_for_CSP(left, right)

% This code is for Re-Shaping the Data for CSP

 % (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 03-Oct-2014

% Input:
              
%        left:  left hand data
%       right: right hand data
% 
% Output:
%       left: Left hand data
%       right: right hand data



% Extract data in such a manner such that the CSP can be applied. 
Left_Class=cat(2,left.C3(:,:,:),left.FC3(:,:,:),left.C5(:,:,:),left.CP3(:,:,:),left.C1(:,:,:),left.C4(:,:,:),left.FC4(:,:,:),left.C2(:,:,:),left.CP4(:,:,:),left.C6(:,:,:));
Right_Class=cat(2,right.C3(:,:,:),right.FC3(:,:,:),right.C5(:,:,:),right.CP3(:,:,:),right.C1(:,:,:),right.C4(:,:,:),right.FC4(:,:,:),right.C2(:,:,:),right.CP4(:,:,:),right.C6(:,:,:));
% the Data is in 
% 1st Dim - sampling points, 
% 2nd Dim - trials.
% 3rd Dim - channels

N_Tr=size(Left_Class,3);

LHH=Left_Class(:,:,1);
    for i=2:N_Tr
         TEMP=Left_Class(:,:,i);
        LHH=vertcat(LHH,TEMP); % Features from each trial 
    end

RHH=Right_Class(:,:,1);
    for i=2:N_Tr
         TEMP=Right_Class(:,:,i);
         RHH=vertcat(RHH,TEMP);% Features from each trial     
    end

end