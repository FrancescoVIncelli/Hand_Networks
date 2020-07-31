%% AIM 2.1 - Compute binary local graph indices in the four conditions (LHM, RHM, LHI, RHI):
% a. Degree
% b. in/out-degree
% c. left hemisphere density
% d. right hemisphere density


%% a-b)
[LHM_out_degrees, LHM_in_degrees, LHM_degrees] = compute_degrees(LHM_PDC_Bin);
[LHI_out_degrees, LHI_in_degrees, LHI_degrees] = compute_degrees(LHI_PDC_Bin);
[RHM_out_degrees, RHM_in_degrees, RHM_degrees] = compute_degrees(RHM_PDC_Bin);
[RHI_out_degrees, RHI_in_degrees, RHI_degrees] = compute_degrees(RHI_PDC_Bin);

%% c-d)


%% Test function: [out_degrees, in_degrees, degrees] = compute_degrees(M)
A = [0,1,1,0,0;
     0,0,0,1,0;
     0,1,0,0,0;
     0,1,0,0,0;
     1,1,0,0,0];

[out_degrees, in_degrees, degrees] = compute_degrees(A);



%% Test function: [density] = compute_density(M)
A = [0,1,1,0,0;
     0,0,0,1,0;
     0,1,0,0,0;
     0,1,0,0,0;
     1,1,0,0,0];

channels = ['Fc2','Cp6','C8','C7','Fc5'];
[left_density, right_density] = compute_hemispheres_density(A, channels)



%% Degree of graph's nodes

function [out_degrees, in_degrees, degrees] = compute_degrees(M)
    %
    % @params
    %     M:            PDC binary matrix with shape (N, N)
    %
    % @return
    %     out_degrees:  1 x N array of out-degrees of all nodes
    %     in_degrees:   1 x N array of in-degrees of all nodes
    %     degrees:      1 x N array of total degrees of all nodes
    %
    
    [rows, cols] = size(M);             % rows = cols = 64
    assert(rows == cols, 'Dimensions of input matrix must be equal.');
    
    in_degrees = zeros(1,rows);         % in-degrees list
    out_degrees = zeros(1,rows);        % out-degrees list
    degrees = zeros(1,rows);            % total degrees list
    for i =1:rows
        for j = 1:cols
            if ne(i,j) & M(i,j)==1
                out_degrees(i)=out_degrees(i)+1;
                in_degrees(j)=in_degrees(j)+1;
            end
        end
    end
    
    for k=1:rows
        degrees(k)=out_degrees(k)+in_degrees(k);
    end
end


%% Density of graph's connections density

function [left_density, right_density] = compute_hemispheres_density(M, channels)
    %
    % @params
    %     M:            PDC binary matrix with shape (N, N)
    %     channels:     recording channel    
    % @return
    %     density:      density of connections in the graph
    %
    
    [n,m] = size(M);
    assert(n == m, 'Dimensions of input matrix must be equal.');
    
    % Get nodes' ids for each hemisphere
    [left, right] = get_hemisphere_ids(channels);
    
    % Compute number of connections in the graph
    Cl = 0; Cr = 0;
    for i=1:n
        for j=1:m
            if ne(i,j)
                if ismember(i,left) & ismember(j,left)
                    Cl = Cl+M(i,j);
                elseif ismember(i,right) & ismember(j,right)
                    Cr = Cr+M(i,j);
                end
            end
        end
    end
    
    C_tot = n*(n-1);
    left_density = Cl / C_tot;
    right_density = Cr / C_tot;
end


%% Get nodes' ids for hemispheres distinction

function [left, right] = get_hemisphere_ids(channels)
    %
    % @params
    %     channels:     recording channel    
    % @return
    %     left:         left channels' nodes ids
    %     right:        right channels' nodes ids
    %
    [N_channels,M] = size(channels);
    right = [];                 % list of ids of right hemisphere channels
    left  = [];                 % list of ids of left hemisphere channels
    for i=1:N_channels          % N=64
        ch = channels(i,1:3);
        tmp = ch-'0';
        id  = tmp(find( tmp >= 0 & tmp < 10, 1 ));
        
        if mod(id,2)
            right = [right,i]
        else
            left = [left,i]
        end
    end
end