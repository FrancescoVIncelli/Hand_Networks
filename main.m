clear
clc
close all
warning off

%% Initialize Parameters
% Frequency from 1 - 64;
freq = 13;
% Set Network Density for threshold calcualation
density = 0.05;

%% Get data LHI, LHM, RHI, RHM
run("dataset_load.m")

%% Compute Partial Directed Coherence
run("pdc_compute.m")

%% Compute Degrees and Density
run("graph_nodes_degrees.m")

%% Plot Graphs
run("graph_compute.m")

figure('Name','Left Hand Actual Movement','NumberTitle','off')
plot_brain(LHM_graph, x_values, y_values);    

figure('Name','Right Hand Actual Movement','NumberTitle','off')
plot_brain(RHM_graph, x_values, y_values);    

disp("----------------------------------------------------");
disp("------------------End of Analysis-------------------");
disp("----------------------------------------------------");


function plot_brain(A, x_values, y_values)    
    plot(A,'XData',x_values,'YData',y_values);
    ax = gca;
    ax.YDir = 'reverse';
    set(gca,'visible','off')
end
