function [BP_Signal]=f_Bandpass_Haider(EEG_SIG, order, band, Smp_Rate)
% This code is for band-pass filtering

 % (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 25-Sept-2014

% Input:
%       EEG_SIG:  EEG Signals, 
              % 1st Dim - sampling points, 
              % 2nd Dim - channels, 
              
%       order:  Order of filter
%       band : bands (for exp: [8, 12] MU mand]
%       Smp_Rate: Sampleing Rate
% Output:
%       BP_Signal:  Band-pass filtered signal

SP.ordFilt = order;             % Order of the filter
SP.fs = Smp_Rate;              % Original Sampling frequency (in Hz) 
SP.F=band;

for j=1:size(SP.F,1)
    
    [B,A]=butter(SP.ordFilt,SP.F(j,:)/SP.fs*2);      
    Signal_in=zeros(1000,size(SP.F,1)*10);
    Data.EEG_SIG=EEG_SIG;
    Signal_in=Data.EEG_SIG([8,2,7,14,9,12,6,11,18,13],:)';
    [N_Samp, N_Sens]=size(Signal_in);
    Signal_mean=mean(Signal_in,1);


        for i=1:N_Sens %% For each channel  
            Signal_in(:,i)=Signal_in(:,i)-Signal_mean(1,i); % Make EEG Data to Zero mean for each channel
            Signal_out(:,i) = filter(B,A,Signal_in(:,i));  %% Filtering       
        end
        if j==1
            BP_Signal=Signal_out;
        end
        if j>1
           BP_Signal=cat(3,BP_Signal,Signal_out);
        end
end
    
end
