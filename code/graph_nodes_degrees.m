%% AIM 2.1 - Compute binary local graph indices in the four conditions (LHM, RHM, LHI, RHI):
% a. Degree
% b. in/out-degree
% c. left hemisphere density
% d. right hemisphere density

function [out_degrees, in_degrees, degrees, left_Hemis, right_Hemis, L_Density, R_Density] = graph_nodes_degrees(PDC_Bin, channels)

% disp("--------------Computing Local Indices---------------");

%% a-b)
[out_degrees, in_degrees, degrees] = compute_degrees(PDC_Bin);

%% c-d)
if channels == 64
    left =  [1, 2, 3, 8,  9,  10, 15, 16, 17, 22, 25, 26, 30, 31, 32, 33, 39, 41, 43, 45, 47, 48, 49, 50, 56, 57, 61];
    right = [5, 6, 7, 12, 13, 14, 19, 20, 21, 24, 28, 29, 35, 36, 37, 38, 40, 42, 44, 46, 52, 53, 54, 55, 59, 60, 63];
end
if channels == 21
    left =  [1, 2, 3, 8,  9,  10, 15, 16, 17];
    right = [5, 6, 7, 12, 13, 14, 19, 20, 21];
end


[left_Hemis] =  get_indices_matrix(left, PDC_Bin);
[right_Hemis] = get_indices_matrix(right, PDC_Bin);

L_Density = get_density_val(left, PDC_Bin);
R_Density = get_density_val(right, PDC_Bin);

% disp('Density Values are,');
% disp(['LHM Left Density: ', num2str(L_Density), ', Right Density: ', num2str(R_Density)]);

% disp("--------Local Indices Computation Complete----------");

end
%% Test function: [out_degrees, in_degrees, degrees] = compute_degrees(M)
% A = [0,1,1,0,0;
%      0,0,0,1,0;
%      0,1,0,0,0;
%      0,1,0,0,0;
%      1,1,0,0,0];
% 
% [out_degrees, in_degrees, degrees] = compute_degrees(A);



%% Test function: [density] = compute_density(M)
% A = [0,1,1,0,0;
%      0,0,0,1,0;
%      0,1,0,0,0;
%      0,1,0,0,0;
%      1,1,0,0,0];

% channels = ['Fc2','Cp6','C8','C7','Fc5'];
% [left_density, right_density] = compute_hemispheres_density(A, channels)



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


%% Get matrix for hemispheres based on channels

function [matrix] = get_indices_matrix(channels, M)
    %
    % @params
    %     channels:     recording channel  
    %            M:     PDC binary matrix with shape (N, N)
    % @return
    %     matrix:       (N,N) Matrix with only edges in channels and rest 0
    %
    matrix = zeros(size(M,2), size(M,2));
    indi = 1;
    indj = 1;
    for i=1:size(channels,2)
        for j=1:size(channels,2)
            matrix(channels(1,i),channels(1,j)) = M(channels(1,i),channels(1,j));
            indj = indj+1;
        end
        indi = indi+1;
        indj = 1;
    end
end

%% Get density of specific channel
    %
    % @params
    %     channels:     recording channel  
    %            M:     PDC binary matrix with shape (N, N)
    % @return
    %      density:       Density of the computed matrix
function [density] = get_density_val(channels, M)
    matrix = zeros(size(channels,2), size(channels,2));
    indi = 1;
    indj = 1;
    for i=1:size(channels,2)
        for j=1:size(channels,2)
            matrix(indi,indj) = M(channels(1,i),channels(1,j));
            indj = indj+1;
        end
        indi = indi+1;
        indj = 1;
    end
    density = density_dir(matrix);
end