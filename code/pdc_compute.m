function [PDC, PDC_Bin, threshold] = pdc_compute(data, freq, density)
    %%% Written by : Akshay Dhonthi
	%     
    % @params
    %         data:      Samples obtained from the patients
    %         freq:      The choosen frequency to get results 
    %      density:      The density required to set threshold
    % @return
    %          PDC:      Partial Directed Coherence of a frequency value
    %      PDC_Bin:      Binary PDC matrix after applying threshold
    %    threshold:      Threshold value of the specified density
    %
    
    %% PDC Computation
    [PDC] = pdc_computation(data);

    %% Choose one of the frequency 
    PDC = PDC(:,:,freq);

    %% Threshold and Weighted to Binary conversion with 20% Density 
    [PDC_Bin, threshold] = set_threshold(PDC, density);

end

%% Threshold set function
function [bin_matrix, threshold] = set_threshold(data, dens)
    %%% Written by : Akshay Dhonthi
	%     
    % @params
    %         data:      NXN PDC matrix after choosing one frequency
    %         dens:      The density to which the threshold to be set
    %
    % @return
    %   bin_matrix:      Binary PDC matrix after applying threshold
    %    threshold:      Threshold value of the specified density
    %
    threshold = 0.0;
    count = 10000;
    while 1
        bin_matrix = data(:,:)>threshold;
        [density, ~, ~] = density_dir(bin_matrix);      
        if density <= dens+0.01
            break
        end
        if count <= 0
            error('Error: Stuck in loop in set_threshold function. Change the density range to a valid number');
        end
        count = count - 1;
        threshold = threshold + 0.0001;
    end
    
    for i = 1:size(bin_matrix,1)
        bin_matrix(i,i) = 0;
    end
end

%% PDC Computation using Orthogonalized Partial Directed Coherence Toolbox 
%%% Written by : Amir Omidvarnia, 2013
%%% Modefied by : Akshay Dhonthi, 2020
%%% Normalization fourmula by : Astolfi et al, 2007

function [PDC] = pdc_computation(data)
	%     
    % @params
    %         data:      Samples obtained from the patients
    %
    % @return
    %          PDC:      Partial Directed Coherence
    %
    
    % Time-invariant MVAR model 
    Fs = 160; % Sampling frequency
    Fmax = Fs/2; % Cut off frequency (Hz), should be smaller than Fs/2
    Nf = 64;

    y = data;
    L = size(y,1); % Number of samples
    CH = size(y,2); % Number of channels

    %%% Written by: Amir Omidvarnia, 2013
    %%% Ref [1]: A.  Omidvarnia,  G.  Azemi,  B.  Boashash,  J.  O.  Toole,  P.  Colditz,  and  S.  Vanhatalo, 
    %%% �Measuring  time-varying  information  flow  in  scalp  EEG  signals:  orthogonalized  partial 
    %%% directed coherence,�  IEEE  Transactions on Biomedical Engineering, 2013  [Epub ahead of print]

    % Time-invariant MVAR parameter estimation
    [~, A, C, sbc, ~, ~] = arfit(y, 1, 20, 'sbc'); % ---> ARFIT toolbox
    [~,p_opt] = min(sbc); % Optimum order for the MVAR model

    [PDC] = get_pdc(A,C,p_opt,Fs,Fmax,Nf);    
    
end

function [PDC] = get_pdc(A,C,p_opt,Fs,Fmax,Nf)
    %% Written by: Amir Omidvarnia
    %%% Modified by: Akshay Dhonthi
    %%% Please see also the functions provided in BioSig Toolbox
    %%% (available at: http://biosig.sourceforge.net)
    %
    % @return
    %          PDC:      Partial Directed Coherence after normalization
    %    
    
    % A = [A1 A2 ... Ap]
    % Nf: Number of frequency points
    % Fmax: maximum frequency limit (should be less than Fs/2)
    [CH,~,T] = size(A);
    PDC   = zeros(CH,CH,Nf,T); % Orthogonalized Partial Directed Coherence

    S   = zeros(CH,CH,Nf,T); % Partial Directed Coherence
    f = (0:Nf-1)*(Fmax/Nf); % Frequency span
    z = 1i*2*pi/Fs;

    for t = 1 : T % Number of time points
        clear A2 
        A2 = [eye(CH) -squeeze(A(:,:,t))];

        C_tmp = squeeze(C(:,:,t));
        Cd = diag(diag(C_tmp)); % Cd is useful for calculation of DC
        invCd = abs(inv(Cd));% invCd is useful for calculation of GPDC
        if(sum(sum(isinf(invCd)))>0)
            invCd = zeros(CH);
        end
        for n = 1 : Nf
            A_f = zeros(CH);
            for k = 1 : p_opt+1
                A_f = A_f + (A2(:,k*CH+(1-CH:0))*exp(z*(k-1)*f(n))); % sum(Ar(f)), r=0:p --> A(f) (if B==I)
            end

            H_f = inv(A_f);

            % Power Spectral Density matrix
            S(:,:,n,t) = (H_f * C_tmp * H_f');

            % Normalization ( Astolfi et al, 2007 )
            for ii = 1:CH
                a_ii = squeeze(A_f(:,ii)); % ii'th column of A(f) --> ak
                a_denum(ii) = (a_ii'*a_ii);
            end
            PDC(:,:,n,t)  = (A_f.*A_f)./a_denum(ones(1,CH),:); % (|Aij|^2) / (sum of m=1 to CH (|Aim|^2))
        end
    end
    PDC = abs(PDC);
end

