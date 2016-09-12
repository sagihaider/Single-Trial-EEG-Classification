function Y = f_spatFilt(x, coef, dimm)

% This code is for obtaining the best components

%   Coded taken by James Ethridge and William Weaver
% Slighly modified by HAIDER RAZA (03/10/2014)
 % (c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 03-Oct-2014

% code by James Ethridge , Will Weaver
%Spatial filtering function. Returns the filtered signal Y.
%
%Inputs:
%x:     the input matrix where M rows are the channels and N columns are the
%       time bins
%
%coef:  the entire P' matrix of filter coefficients
%
%dimm:  the number of dimensions the filter should attemp to reduce the
%       output vector space to

    [m n] = size(coef);

    %check for valid dimensions
    if(m<dimm)
        disp('Cannot reduce to a higher dimensional space!');
        return
    end

    %instantiate filter matrix
    Ptild = zeros(dimm,n);

    %create the n-dimensional filter by sorting
    i=0;
    for d = 1:dimm

     if(mod(d,2)==0)   
        Ptild(d,:) = coef(m-i,:);
        i=i+1;
     else
        Ptild(d,:) = coef(1+i,:);
     end

    end
    
    %get length of input signal
    T = length(x);
    %instantiate output matrix
    Y=zeros(dimm,T);
    
    %filtering
    for d = 1:dimm
       for t = 1:T 
       Y(d,t) = dot(Ptild(d,:),x(:,t));
       end
    end
   
    return
    
