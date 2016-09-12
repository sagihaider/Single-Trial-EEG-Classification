(c) Haider Raza, Intelligent System Research Center, University of Ulster, Northern Ireland, UK.
%     Raza-H@email.ulster.ac.uk
%     Date: 27-Jan-2014
% Cite this work on the citation given below
% @article{raza2015adaptive,
%   title={Adaptive learning with covariate shift-detection for motor imagery-based brain--computer interface},
%   author={Raza, Haider and Cecotti, Hubert and Li, Yuhua and Prasad, Girijesh},
%   journal={Soft Computing},
%   pages={1--12},
%   year={2015},
%   publisher={Springer}
% }
%  % -------------------------------------------------------------------------
%                  File Name: Single-Trial EEG classification

main file: main_EEG_Classification.m

"main_EEG_Classification.m" includes the following steps

1) Load data for BCI Competition-IV dataset 2A- Subject A01: Training and Testing Data 
2) Band-pass filtering the data in two different frequency bands: [8-12] Hz and [14-30] Hz (i.e. mu and beta band respectively)
3) Use training band-pass filtered data to compute the CSP projected matrix and use it to project the data into surrogate space. 
4) Compute the log variance feature for each trial in 3-6s section.
5) Train a classifier.

6) Repeat same steps (1-4) of feature extraction and classify each trials. 

Good Luck!
For any error or bugs contact me at 'sagihaider@gmail.com'




