%% Plot Graphs
disp("----------------------------------------------------");
disp("------------Topographical Representaion-------------");
disp("----------------------------------------------------");

% Load positions of nodes obtained from the image
load('nodePos.mat')
names = transpose(cellstr(header1.channels));

% A = randn(4,4); A = A(:,:)<0.5; A(1,1)=0; A(2,2)=0; A(3,3)=0; A(4,4)=0;

% Graphs for 64 channels
[s, t] = get_edges_nodes(LHM_PDC_Bin);
weights = zeros(1,size(s, 2));
LHM_graph = digraph(s,t, weights, names);

[s, t] = get_edges_nodes(LHI_PDC_Bin);
weights = zeros(1,size(s, 2));
LHI_graph = digraph(s,t, weights, names);

[s, t] = get_edges_nodes(RHM_PDC_Bin);
weights = zeros(1,size(s, 2));
RHM_graph = digraph(s,t, weights, names);

[s, t] = get_edges_nodes(RHI_PDC_Bin);
weights = zeros(1,size(s, 2));
RHI_graph = digraph(s,t, weights, names);

% Graphs for Left and Right Hemisphere
[s, t] = get_edges_nodes(LHM_left_Hemis);
weights = zeros(1,size(s, 2));
LHM_L_graph = digraph(s,t, weights, names);
[s, t] = get_edges_nodes(LHM_right_Hemis);
weights = zeros(1,size(s, 2));
LHM_R_graph = digraph(s,t, weights, names);

[s, t] = get_edges_nodes(LHI_left_Hemis);
weights = zeros(1,size(s, 2));
LHI_L_graph = digraph(s,t, weights, names);
[s, t] = get_edges_nodes(LHI_right_Hemis);
weights = zeros(1,size(s, 2));
LHI_R_graph = digraph(s,t, weights, names);

[s, t] = get_edges_nodes(RHM_left_Hemis);
weights = zeros(1,size(s, 2));
RHM_L_graph = digraph(s,t, weights, names);
[s, t] = get_edges_nodes(RHM_right_Hemis);
weights = zeros(1,size(s, 2));
RHM_R_graph = digraph(s,t, weights, names);

[s, t] = get_edges_nodes(RHI_left_Hemis);
weights = zeros(1,size(s, 2));
RHI_L_graph = digraph(s,t, weights, names);
[s, t] = get_edges_nodes(RHI_right_Hemis);
weights = zeros(1,size(s, 2));
RHI_R_graph = digraph(s,t, weights, names);

function [s, t] = get_edges_nodes(A)
    s = [];
    t = [];
    for i = 1:size(A,1)
        for j = 1:size(A,2)
            if A(i,j) == 1
                s = [s, i];
                t = [t, j];
            end
        end   
    end
end