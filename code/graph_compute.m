%% Plot Graphs
function [graph, L_graph, R_graph] = graph_compute(PDC_Bin, CH, left_Hemis, right_Hemis, header)
    %%% Written by : Akshay Dhonthi
	%     
    % @params
    %        PDC_Bin:      Binary PDC Matrix
    %             CH:      Number of channels (64 or 21)
    %     left_Hemis:      Left Hemisphere Matrix
    %    right_Hemis:      Right Hemisphere Matrix
    %         header:      Header to get the labels
    % @return
    %          graph:      Graph file containing nodes and edges
    %        L_graph:      Left hemisphere graph
    %        R_graph:      Right hemisphere graph
    %
    
    % Load positions of nodes obtained from the image
    load(fullfile('..','data','nodePos.mat'))
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
    %%% Written by : Akshay Dhonthi
	%     
    % @params
    %        A:      Matrix to get nodes and edges from
    % @return
    %        s:      The initial node array
    %        t:      Respective destination node array
    %
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