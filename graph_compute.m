%% Plot Graphs
function [graph, L_graph, R_graph] = graph_compute(PDC_Bin, CH, left_Hemis, right_Hemis, header)

% disp("-----------------Get Graph Diagram------------------");

% Load positions of nodes obtained from the image
load('nodePos.mat')
names = transpose(cellstr(header.channels(1:CH,:)));

% Graphs
[s, t] = get_edges_nodes(PDC_Bin);
weights = zeros(1,size(s, 2));
graph = digraph(s,t, weights, names);

% Graphs for Left and Right Hemisphere
[s, t] = get_edges_nodes(left_Hemis);
weights = zeros(1,size(s, 2));
L_graph = digraph(s,t, weights, names);
[s, t] = get_edges_nodes(right_Hemis);
weights = zeros(1,size(s, 2));
R_graph = digraph(s,t, weights, names);

end

%%
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