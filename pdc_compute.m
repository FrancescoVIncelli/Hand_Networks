clear
clc
close all
warning off

% Get data LHI, LHM, RHI, RHM
run("dataset_load.m")

[LHM_PDC] = pdc_computation(LHM);
[LHI_PDC] = pdc_computation(LHI);
[RHM_PDC] = pdc_computation(RHM);
[RHI_PDC] = pdc_computation(RHI);

%% Choose one of the frequency 
freq = 13;
LHM_PDC = LHM_PDC(:,:,freq);
LHI_PDC = LHI_PDC(:,:,freq);
RHM_PDC = RHM_PDC(:,:,freq);
RHI_PDC = RHI_PDC(:,:,freq);


%% Threshold and Weighted to Binary conversion with 20% Density 
LHM_threshold = 0.0419;
LHI_threshold = 0.0432;
RHM_threshold = 0.0391;
RHI_threshold = 0.0436;

LHM_PDC_Bin = LHM_PDC(:,:)<LHM_threshold;
LHI_PDC_Bin = LHI_PDC(:,:)<LHI_threshold;
RHM_PDC_Bin = RHM_PDC(:,:)<RHM_threshold;
RHI_PDC_Bin = RHI_PDC(:,:)<RHI_threshold;

% [kden,N,K] = density_dir(temp)
[LHM_Den, ~, ~] = density_dir(LHM_PDC_Bin);
[LHI_Den, ~, ~] = density_dir(LHI_PDC_Bin);
[RHM_Den, ~, ~] = density_dir(RHM_PDC_Bin);
[RHI_Den, ~, ~] = density_dir(RHI_PDC_Bin);

%% Time-invariant simulation for gOPDC analysis represented in ref [1] (Fig. 3)
%%% Written by: Amir Omidvarnia, 2013
%%% Ref [1]: A.  Omidvarnia,  G.  Azemi,  B.  Boashash,  J.  O.  Toole,  P.  Colditz,  and  S.  Vanhatalo, 
%%% �Measuring  time-varying  information  flow  in  scalp  EEG  signals:  orthogonalized  partial 
%%% directed coherence,�  IEEE  Transactions on Biomedical Engineering, 2013  [Epub ahead of print]

function [PDC] = pdc_computation(data)
    disp("PDC Computation");
    % Time-invariant MVAR model 
    Fs = 160; % Sampling frequency
    Fmax = Fs/2; % Cut off frequency (Hz), should be smaller than Fs/2
    Nf = 64;

    y = data;
    L = size(y,1); % Number of samples
    CH = size(y,2); % Number of channels

    % Time-invariant MVAR parameter estimation
    [w, A, C, sbc, fpe, th] = arfit(y, 1, 20, 'sbc'); % ---> ARFIT toolbox
    [tmp,p_opt] = min(sbc); % Optimum order for the MVAR model
    % Connectivity measures (PDC, gOPDC etc)
    [GPDC,OPDC,PDC,GOPDC,S] = PDC_dDTF_imag(A,C,p_opt,Fs,Fmax,Nf);
    PDC = abs(PDC);
end