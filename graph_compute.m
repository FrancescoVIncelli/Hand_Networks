%% Plot Graphs

% Load positions of nodes obtained from the image
load('nodePos.mat')
names = transpose(cellstr(header1.channels));

% A = randn(4,4); A = A(:,:)<0.5; A(1,1)=0; A(2,2)=0; A(3,3)=0; A(4,4)=0;


[s, t] = get_edges_nodes(LHM_PDC_Bin);
weights = zeros(1,size(s, 2));
G = digraph(s,t, weights, names);
figure('Name','Left Hand Actual Movement','NumberTitle','off')
p = plot(G,'XData',x_values,'YData',y_values);
ax = gca;
ax.YDir = 'reverse';
set(gca,'visible','off')

[s, t] = get_edges_nodes(RHM_PDC_Bin);
weights = zeros(1,size(s, 2));
G = digraph(s,t, weights, names);
figure('Name','Right Hand Actual Movement','NumberTitle','off')
q = plot(G,'XData',x_values,'YData',y_values);
ax = gca;
ax.YDir = 'reverse';
set(gca,'visible','off')


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