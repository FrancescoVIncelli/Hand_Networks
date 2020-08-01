disp('Parameter Initializations,');
disp(['Choosen Frequency: ', num2str(freq)]);
disp(['Choosen Network Density: ', num2str(density)]);

%% PDC Computation
[LHM_PDC] = pdc_computation(LHM);
[LHI_PDC] = pdc_computation(LHI);
[RHM_PDC] = pdc_computation(RHM);
[RHI_PDC] = pdc_computation(RHI);

%% Choose one of the frequency 
LHM_PDC = LHM_PDC(:,:,freq);
LHI_PDC = LHI_PDC(:,:,freq);
RHM_PDC = RHM_PDC(:,:,freq);
RHI_PDC = RHI_PDC(:,:,freq);

%% Threshold and Weighted to Binary conversion with 20% Density 
[LHM_PDC_Bin, LHM_threshold] = set_threshold(LHM_PDC, density);
[LHI_PDC_Bin, LHI_threshold] = set_threshold(LHI_PDC, density);
[RHM_PDC_Bin, RHM_threshold] = set_threshold(RHM_PDC, density);
[RHI_PDC_Bin, RHI_threshold] = set_threshold(RHI_PDC, density);

disp("-------------PDC Computation Complete---------------");

disp('Threshold Values are,');
disp(['LHM Threshold: ', num2str(LHM_threshold)]);
disp(['LHI Threshold: ', num2str(LHI_threshold)]);
disp(['RHM Threshold: ', num2str(RHM_threshold)]);
disp(['RHI Threshold: ', num2str(RHI_threshold)]);

%% Threshold set function

function [bin_matrix, threshold] = set_threshold(data, dens)
    threshold = 0.0;
    count = 10000;
    while 1
        bin_matrix = data(:,:)<threshold;
        [density, ~, ~] = density_dir(bin_matrix);       
        if density >=dens
            break
        end
        if count <= 0
            error('Error: Stuck in loop in set_threshold function. Change the density range to a valid number');
        end
        count = count - 1;
        threshold = threshold + 0.0001;
    end
end

%% Time-invariant simulation for gOPDC analysis represented in ref [1] (Fig. 3)
%%% Written by: Amir Omidvarnia, 2013
%%% Ref [1]: A.  Omidvarnia,  G.  Azemi,  B.  Boashash,  J.  O.  Toole,  P.  Colditz,  and  S.  Vanhatalo, 
%%% �Measuring  time-varying  information  flow  in  scalp  EEG  signals:  orthogonalized  partial 
%%% directed coherence,�  IEEE  Transactions on Biomedical Engineering, 2013  [Epub ahead of print]

function [PDC] = pdc_computation(data)
    disp("----------------PDC Computation---------------------");
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