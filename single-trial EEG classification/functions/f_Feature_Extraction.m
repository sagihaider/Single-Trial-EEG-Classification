function [Features]=f_Feature_Extraction(EEG_SIG_Tr, EEG_SIG_Ts,Labels_T, Labels_E,Triggers_T, Triggers_E, band, order, Subject_No, Smp_Rate, time_point)
% features for each ban
i=0;

for j=1:length(band)
    
    % function for EEG Band-Pass filtering for Training Data
    time_point=384:768; % Time of Interest s
    [Signal_out_Tr]=f_Bandpass_Haider(EEG_SIG_Tr, order, band(j,:), Smp_Rate);
    
    % Function to Convert the training data in Epochs and Channels Wise
    
    [Tr_left, Tr_right]=f_Convert_Into_Epochs(Signal_out_Tr, Triggers_T, Labels_T, time_point);
    
    
    % function for EEG Band-Pass filtering for Testing Data
    [Signal_out_Ts]=f_Bandpass_Haider(EEG_SIG_Ts, order, band(j,:), Smp_Rate);
    
    % Function to Convert the test data in Epochs and Channels Wise
    [Ts_left, Ts_right]=f_Convert_Into_Epochs(Signal_out_Ts, Triggers_E, Labels_E, time_point);
    
    %%
    %==========================================================================
    %#################### Feature Extraction for Training #####################
    disp('### Reshaping Data to apply the CSP ###')
    
    % Function to Convert the test data in Epochs and Channels Wise
    [CSP_LHH, CSP_RHH]=f_Reshape_Data_for_CSP(Tr_left, Tr_right);
    
    % Calculate CSP Projection Matrix
    [PTranspose] = f_CSP(CSP_LHH',CSP_RHH');
    
    
    % Combine Left hand and Right Data
    classtrain= horzcat(CSP_LHH',CSP_RHH');
    
    % Select the Best Components
    No_of_Components=2;
    train = f_spatFilt(classtrain, PTranspose, No_of_Components);
    
    % Select the specific window of data from each trail and compute the log
    % varince feature for each trial.
    [Samp_Pts,Chan, No_Trials]=size(Tr_left.C3);
    Total_Trials=No_Trials*2;
    
    [Xf_left, Xf_right]=f_Extract_Features(train, time_point, Samp_Pts, No_Trials, Total_Trials, No_of_Components);
    
    % Combine the left and right hand features
    Xf=[Xf_left ; Xf_right];
    
    % Plot the Features after CSP
    
    % Get the line
    All_A=[Xf_left(:,1) ; Xf_right(:,1)];
    All_B=[Xf_left(:,2) ; Xf_right(:,2)];
    minA=min(All_A);
    minB=min(All_B);
    maxA=max(All_A);
    maxB=max(All_B);
    
    i=i+1;
    
    figure(i)
    scatter(Xf_left(:,1),Xf_left(:,2),10,'b+'); hold on;
    scatter(Xf_right(:,1),Xf_right(:,2),8,'ro');
    % Draw Ellipse
    [e1,e2]=f_plot_ellipse(Xf_left,Xf_right);
    hold on;
    plot(e1(1,:), e1(2,:), 'Color','k');
    plot(e2(1,:), e2(2,:), 'Color','k');
    
    hold on
    
    GT=[ zeros(72,1) ; ones(72,1) ];
    [class,err,POSTERIOR,logp,coeff] = classify([Xf_left ; Xf_right],[Xf_left ; Xf_right],GT);
    K = coeff(1,2).const;
    L = coeff(1,2).linear;
    f = @(x1,x2) K + L(1)*x1 + L(2)*x2;
    h3 = ezplot(f,[minA maxA minB maxB]);
    set(h3,'Color',[0 0 0]);
    set(h3,'LineWidth',1);
    xlabel('First best feature','FontWeight','bold');
    ylabel('Second best feature','FontWeight','bold');
    title('{\bfTrain data (CSP)}')
    
    
    
    %==========================================================================
    %#################### Feature Extraction for Testing #####################
    disp('### Reshaping Data to apply the CSP of Test Data ###')
    
    % Function to Convert the test data in Epochs and Channels Wise
    [LHH_CSP, RHH_CSP]=f_Reshape_Data_for_CSP(Ts_left, Ts_right);
    
    % Combine Left hand and Right Data
    classtest= horzcat(LHH_CSP',RHH_CSP');
    
    % Select the Best Components
    test = f_spatFilt(classtest,PTranspose,No_of_Components);
    
    % Select the specific window of data from each trail and compute the log
    % varince feature for each trial.
    [TEST_X]=f_Extract_Features_Test(test,time_point,Samp_Pts,Total_Trials,No_of_Components);
    
    %         if(j==1)
    %             Test_X=TEST_X;
    %         else
    %             Test_X=cat(2,Test_X,TEST_X);
    %         end
    Test_X=TEST_X;
    
    
    lf=Xf(1:70,:);
    rh=Xf(73:142,:);
    Train_X=horzcat(lf',rh'); % Training Data
    Train_Y=[zeros(1,70), ones(1,70)]; % Training Label
    
    % Labels for the Test Data
    Test_Y=[zeros(1,72), ones(1,72)];
    
    Features{j}.Sub_Code=Subject_No;
    Features{j}.time_point=time_point;
    Features{j}.band=band(j,:);
    Features{j}.Train_X=Train_X;
    Features{j}.Train_Y=Train_Y;
    Features{j}.Test_X=Test_X;
    Features{j}.Test_Y=Test_Y;
end

