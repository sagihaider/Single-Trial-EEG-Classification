function [left, right]=f_Convert_Into_Epochs(Signal_out, Triggers, Labels, time_point)
% This code is for Coverting the Data Into Epochs

 % (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 03-Oct-2014

% Input:
%       Signal_out:  Band-passed EEG Signals, 
              % 1st Dim - sampling points, 
              % 2nd Dim - channels, 
              
%       Tiggers:  Triggers of The Cue
%       Label: Labels of the session
% 
% Output:
%       left: Left hand data
%       right: right hand data

for i=1:length(Labels) 
    
trail_points=((Triggers.Start_Pos(i,1)):(Triggers.End_Pos(i,1)-1));

EEG.C3(:,:,i)=squeeze(Signal_out(trail_points,1));
EEG.FC3(:,:,i)=squeeze(Signal_out(trail_points,2));
EEG.C5(:,:,i)=squeeze(Signal_out(trail_points,3));
EEG.CP3(:,:,i)=squeeze(Signal_out(trail_points,4));
EEG.C1(:,:,i)=squeeze(Signal_out(trail_points,5));

EEG.C4(:,:,i)=squeeze(Signal_out(trail_points,6));
EEG.FC4(:,:,i)=squeeze(Signal_out(trail_points,7));
EEG.C2(:,:,i)=squeeze(Signal_out(trail_points,8));
EEG.CP4(:,:,i)=squeeze(Signal_out(trail_points,9));
EEG.C6(:,:,i)=squeeze(Signal_out(trail_points,10));
end

%------------------------------------------------------------------------
%##########################################################
% Fetch the data according to Left hand and Right hand Trials

lindex=find(Labels(:,1)==1); % Find the left Labels
rindex=find(Labels(:,1)==2); % Find the right labels

left.C3=EEG.C3(time_point,:,lindex); % Trainign Data for C3 Left
left.FC3=EEG.FC3(time_point,:,lindex); % Trainign Data for FC3 Left
left.C5=EEG.C5(time_point,:,lindex); % Trainign Data for C5 Left
left.CP3=EEG.CP3(time_point,:,lindex); % Trainign Data for CP3 Left
left.C1=EEG.C1(time_point,:,lindex); % Trainign Data for C1 Left
left.C4=EEG.C4(time_point,:,lindex); % Trainign Data for C4 Left
left.FC4=EEG.FC4(time_point,:,lindex); % Trainign Data for FC4 Left
left.C2=EEG.C2(time_point,:,lindex); % Trainign Data for C2 Left
left.CP4=EEG.CP4(time_point,:,lindex); % Trainign Data for CP4 Left
left.C6=EEG.C6(time_point,:,lindex); % Trainign Data for C6 Left

right.C3=EEG.C3(time_point,:,rindex); % Trainign Data for C3 right
right.FC3=EEG.FC3(time_point,:,rindex); % Trainign Data for FC3 right
right.C5=EEG.C5(time_point,:,rindex); % Trainign Data for C5 right
right.CP3=EEG.CP3(time_point,:,rindex); % Trainign Data for CP3 right
right.C1=EEG.C1(time_point,:,rindex); % Trainign Data for C1 right
right.C4=EEG.C4(time_point,:,rindex); % Trainign Data for C4 right
right.FC4=EEG.FC4(time_point,:,rindex); % Trainign Data for FC4 right
right.C2=EEG.C2(time_point,:,rindex); % Trainign Data for C2 right
right.CP4=EEG.CP4(time_point,:,rindex); % Trainign Data for CP4 right
right.C6=EEG.C6(time_point,:,rindex); % Trainign Data for C6 right

end