%% Topographical Plots Efficiency Indices
%%% Francesco Vincelli, 2020
warning off

% Load channels locations system file
% locs_filename=fullfile('..','data','locations.mat');
% load(locs_filename);

% 64-21 Channels lists
ch_list_64 = {'FC5','FC3','FC1','FCZ','FC2','FC4','FC6','C5','C3','C1','CZ',...
        'C2','C4','C6','CP5','CP3','CP1','CPZ','CP2','CP4','CP6','FP1','FPZ',...
        'FP2','AF7','AF3','AFZ','AF4','AF8','F7','F5','F3','F1','FZ','F2',...
        'F4','F6','F8','FT7','FT8','T7','T8','T9','T10','TP7','TP8','P7',...
        'P5','P3','P1','PZ','P2','P4','P6','P8','PO7','PO3','POZ','PO4',...
        'PO8','O1','OZ','O2','IZ'};
    
ch_list_21 = {'FC5','FC3','FC1','FCZ','FC2','FC4','FC6','C5','C3',...
    'C1','CZ','C2','C4','C6','CP5','CP3','CP1','CPZ','CP2','CP4','CP6'};


%% Group data for graphical comparison %%

%% Left Hand Execution/Imagination Movement Comparisons
LeftHand_CH_64_f1 = [LHM_CH_64_f1, LHI_CH_64_f1];
LeftHand_CH_64_f2 = [LHM_CH_64_f2, LHI_CH_64_f2];
LeftHand_CH_21_f1 = [LHM_CH_21_f1, LHI_CH_21_f1];
LeftHand_CH_21_f2 = [LHM_CH_21_f2, LHI_CH_21_f2];


%% Right Hand Execution/Imagination Movement Comparisons
RightHand_CH_64_f1 = [RHM_CH_64_f1, RHI_CH_64_f1];
RightHand_CH_64_f2 = [RHM_CH_64_f2, RHI_CH_64_f2];
RightHand_CH_21_f1 = [RHM_CH_21_f1, RHI_CH_21_f1];
RightHand_CH_21_f2 = [RHM_CH_21_f2, RHI_CH_21_f2];

%% Left-Right Execution Movement Comparisons
LR_Exec_CH_64_f1 = [LHM_CH_64_f1, RHM_CH_64_f1];
LR_Exec_CH_64_f2 = [LHM_CH_64_f2, RHM_CH_64_f2];
LR_Exec_CH_21_f1 = [LHM_CH_21_f1, RHM_CH_21_f1];
LR_Exec_CH_21_f2 = [LHM_CH_21_f2, RHM_CH_21_f2];

%% Left-Right Imagination Movement Comparisons
LR_Imag_CH_64_f1 = [LHI_CH_64_f1, RHI_CH_64_f1];
LR_Imag_CH_64_f2 = [LHI_CH_64_f2, RHI_CH_64_f2];
LR_Imag_CH_21_f1 = [LHI_CH_21_f1, RHI_CH_21_f1];
LR_Imag_CH_21_f2 = [LHI_CH_21_f2, RHI_CH_21_f2];


%% Set plottings arguments

%% Left Hand Execution/Imagination Movement Comparisons

keys_LH_Ch64_f1={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LH_Ch64_f1=["multiple","f1","64","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_LH_Ch64_f1=containers.Map(keys_LH_Ch64_f1,values_LH_Ch64_f1);

keys_LH_Ch64_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LH_Ch64_f2=["multiple","f2","64","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_LH_Ch64_f2=containers.Map(keys_LH_Ch64_f2,values_LH_Ch64_f2);

keys_LH_Ch21_f1={'plotType','freqs','channels','compare','figureName,','dataIds'};
values_LH_Ch21_f1=["multiple","f1","21","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_LH_Ch21_f1=containers.Map(keys_LH_Ch21_f1,values_LH_Ch21_f1);

keys_LH_Ch21_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LH_Ch21_f2=["multiple","f2","21","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_LH_Ch21_f2=containers.Map(keys_LH_Ch21_f2,values_LH_Ch21_f2);


%% Right Hand Execution/Imagination Movement Comparisons

keys_RH_Ch64_f1={'plotType','freqs','channels','compare','figureName','dataIds'};
values_RH_Ch64_f1=["multiple","f1","64","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_RH_Ch64_f1=containers.Map(keys_RH_Ch64_f1,values_RH_Ch64_f1);

keys_RH_Ch64_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_RH_Ch64_f2=["multiple","f2","64","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_RH_Ch64_f2=containers.Map(keys_RH_Ch64_f2,values_RH_Ch64_f2);

keys_RH_Ch21_f1={'plotType','freqs','channels','compare','figureName,','dataIds'};
values_RH_Ch21_f1=["multiple","f1","21","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_RH_Ch21_f1=containers.Map(keys_RH_Ch21_f1,values_RH_Ch21_f1);

keys_RH_Ch21_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_RH_Ch21_f2=["multiple","f2","21","exec-imag","Left Hand Execution/Imagination Movement","LHM_LHI"];
args_RH_Ch21_f2=containers.Map(keys_RH_Ch21_f2,values_RH_Ch21_f2);


%% Left\Right Hand Execution Movement Comparisons

keys_LRM_Ch64_f1={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LRM_Ch64_f1=["multiple","f1","64","left-right","Left\Right Hand Execution Movement","LHM_RHM"];
args_LRM_Ch64_f1=containers.Map(keys_LRM_Ch64_f1,values_LRM_Ch64_f1);

keys_LRM_Ch64_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LRM_Ch64_f2=["multiple","f2","64","left-right","Left\Right Hand Execution Movement","LHM_RHM"];
args_LRM_Ch64_f2=containers.Map(keys_LRM_Ch64_f2,values_LRM_Ch64_f2);

keys_LRM_Ch21_f1={'plotType','freqs','channels','compare','figureName,','dataIds'};
values_LRM_Ch21_f1=["multiple","f1","21","left-right","Left\Right Hand Execution Movement","LHM_RHM"];
args_LRM_Ch21_f1=containers.Map(keys_LRM_Ch21_f1,values_LRM_Ch21_f1);

keys_LRM_Ch21_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LRM_Ch21_f2=["multiple","f2","21","left-right","Left\Right Hand Execution Movement","LHM_RHM"];
args_LRM_Ch21_f2=containers.Map(keys_LRM_Ch21_f2,values_LRM_Ch21_f2);


%% Left\Right Hand Imagination Movement Comparisons

keys_LRI_Ch64_f1={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LRI_Ch64_f1=["multiple","f1","64","exec-imag","Left\Right Hand Imagination Movement","LHI_RHI"];
args_LEI_Ch64_f1=containers.Map(keys_LRI_Ch64_f1,values_LRI_Ch64_f1);

keys_LRI_Ch64_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LRI_Ch64_f2=["multiple","f2","64","exec-imag","Left\Right Hand Imagination Movement","LHI_RHI"];
args_LRI_Ch64_f2=containers.Map(keys_LRI_Ch64_f2,values_LRI_Ch64_f2);

keys_LRI_Ch21_f1={'plotType','freqs','channels','compare','figureName,','dataIds'};
values_LRI_Ch21_f1=["multiple","f1","21","exec-imag","Left\Right Hand Imagination Movement","LHI_RHI"];
args_LRI_Ch21_f1=containers.Map(keys_LRI_Ch21_f1,values_LRI_Ch21_f1);

keys_LRI_Ch21_f2={'plotType','freqs','channels','compare','figureName','dataIds'};
values_LRI_Ch21_f2=["multiple","f2","21","exec-imag","Left\Right Hand Imagination Movement","LHI_RHI"];
args_LRI_Ch21_f2=containers.Map(keys_LRI_Ch21_f2,values_LRI_Ch21_f2);


%% Plot Efficiency Maps

% %% Left Hand Execution/Imagination Movement
% efficiency_plots(LeftHand_CH_64_f1, args_LH_Ch64_f1, ch_list_64);
% efficiency_plots(LeftHand_CH_64_f2, args_LH_Ch64_f2, ch_list_64);
% pause(0.5)
% efficiency_plots(LeftHand_CH_21_f1, args_LH_Ch21_f1, ch_list_21);
% efficiency_plots(LeftHand_CH_21_f2, args_LH_Ch21_f2, ch_list_21);
% 
% %% Right Hand Execution/Imagination Movement
% efficiency_plots(RightHand_CH_64_f1, args_RH_Ch64_f1, ch_list_64);
% efficiency_plots(RightHand_CH_64_f2, args_RH_Ch64_f2, ch_list_64);
% pause(0.5);
% efficiency_plots(RightHand_CH_21_f1, args_RH_Ch21_f1, ch_list_21);
% efficiency_plots(RightHand_CH_21_f2, args_RH_Ch21_f2, ch_list_21);

%% Left\Right Hand Execution Movement
efficiency_plots(LR_Exec_CH_64_f1, args_LRM_Ch64_f1, ch_list_64);
efficiency_plots(LR_Exec_CH_64_f2, args_LRM_Ch64_f2, ch_list_64);
%pause(0.5)
efficiency_plots(LR_Exec_CH_21_f1, args_LRM_Ch21_f1, ch_list_21);
efficiency_plots(LR_Exec_CH_21_f2, args_LRM_Ch21_f1, ch_list_21);

%% Left\Right Hand Imagination Movement
efficiency_plots(LR_Imag_CH_64_f1, args_LRI_Ch64_f1, ch_list_64);
efficiency_plots(LR_Imag_CH_64_f2, args_LRI_Ch64_f1, ch_list_64);
%pause(0.5)
efficiency_plots(LR_Imag_CH_21_f1, args_LRI_Ch21_f1, ch_list_21);
efficiency_plots(LR_Imag_CH_21_f2, args_LRI_Ch21_f1, ch_list_21);


function efficiency_plots(data, args, ch_list)
    plotType=args('plotType');
    freqs=args('freqs');
    channels=args('channels');
    compare=args('compare');
    dataIds=args('dataIds'); ids=strsplit(dataIds,'_');
    figureName=args('figureName');
    
    pltKeys={'plotTitle','windowName','windowState','numPlots'};
    
    switch compare
        case "left-right"
            windowName=sprintf("%s: Efficiency Indices || Channels: %s | Frequencies: %s",figureName, channels, freqs);
            plotTitle=[sprintf('%s Global/Local Efficiency', ids{1}),...
                sprintf('%s Global/Local Efficiency', ids{2})];
                
            numPlots=2;
            windowState='maximized';
            
            pltValues=[plotTitle,windowName,windowState,numPlots];
            pltArgs=containers.Map(pltKeys,pltValues);
            multiple_maps(data,pltArgs, ch_list);
        
        case "exec-imag"
            windowName=sprintf("%s: Efficiency Indices || Channels: %s | Frequencies: %s",figureName, channels,freqs);
            plotTitle=[sprintf('%s Global/Local Efficiency', ids{1}),...
                sprintf('%s Global/Local Efficiency', ids{2})];

            numPlots=2;
            windowState='maximized';

            pltValues=[plotTitle,windowName,windowState,numPlots];
            pltArgs=containers.Map(pltKeys,pltValues);
            multiple_maps(data,pltArgs, ch_list);
    end
         
end

function multiple_maps(data,args, ch_list)
    % Get plot arguments
    windowName=args('windowName');
    windowState=args('windowState');
    plotTitle=args('plotTitle');
    n_plots = str2num(args('numPlots'));
    
    fig = figure('Name',windowName,'WindowState',windowState);
    
    if n_plots==2
        % disp("_____efficiency_map______")
        % Two-columns plot
        idx=0;
        len=size(plotTitle,2)/2;
        for i=1:n_plots
            ha(i) = subplot(1,2,i)
            efficiency_map(data(i), ch_list);

            % Set plot title
            plt_title = plotTitle(1,len*idx+1:len*(idx+1));
            title(plt_title);
            idx=idx+1;
        end
        
        %  dim = [.2 .5 .3 .3];
        %  str = sprintf('(Average) Local Efficiency: %s || GLobal Efficiency: %s',data.local_efficiency_avg, data.global_efficiency);
        %  annotation('textbox',dim,'String',str,'FitBoxToText','on');
        arrayfun(@(x) pbaspect(x, [1 1 1]), ha);
        drawnow;
        
        pos = arrayfun(@plotboxpos, ha, 'uni', 0);
        dim = cellfun(@(x) x.*[1 0.5 1 1], pos, 'uni',0);
        for ia=1:n_plots
            str = sprintf(...
                '(Average) Local Efficiency: %s || GLobal Efficiency: %s',...
                data(ia).local_efficiency_avg, data(ia).global_efficiency);
            annotation(fig, 'textbox',  dim{ia}, 'String', str, 'vert', 'bottom', 'FitBoxToText','on');
        end
    elseif n_plots==4
        idx=0;
        len=size(plotTitle,2)/4;
        for i=1:n_plots
            subplot(2,2,i)
            efficiency_map(data(i),ch_list);
            
            % Set plot title
            plt_title = plotTitle(1,len*idx+1:len*(idx+1));
            title(plt_title);
            idx=idx+1;
        end
    end
end

function tp = efficiency_map(data,ch_list)
    locs_filename=fullfile('..','data','locations.mat');

%     ch_list = {'FC5','FC3','FC1','FCZ','FC2','FC4','FC6','C5','C3','C1','CZ',...
%         'C2','C4','C6','CP5','CP3','CP1','CPZ','CP2','CP4','CP6','FP1','FPZ',...
%         'FP2','AF7','AF3','AFZ','AF4','AF8','F7','F5','F3','F1','FZ','F2',...
%         'F4','F6','F8','FT7','FT8','T7','T8','T9','T10','TP7','TP8','P7',...
%         'P5','P3','P1','PZ','P2','P4','P6','P8','PO7','PO3','POZ','PO4',...
%         'PO8','O1','OZ','O2','IZ'};
    
    lev=data.local_efficiency_all;
    
    tp = plot_topography(ch_list,lev,1,locs_filename);
    cbar=colorbar;
    set(get(cbar,'label'),'string','Local Efficiency (Each node)');
end

function save_system_CH64_file()
    locations = system_CH64_table();
    filename=fullfile('..','data','locations.mat')
    save(filename);
end

function locations_CH64 = system_CH64_table()
    ch_list = {'FC5','FC3','FC1','FCZ','FC2','FC4','FC6','C5','C3','C1','CZ',...
        'C2','C4','C6','CP5','CP3','CP1','CPZ','CP2','CP4','CP6','FP1','FPZ',...
        'FP2','AF7','AF3','AFZ','AF4','AF8','F7','F5','F3','F1','FZ','F2',...
        'F4','F6','F8','FT7','FT8','T7','T8','T9','T10','TP7','TP8','P7',...
        'P5','P3','P1','PZ','P2','P4','P6','P8','PO7','PO3','POZ','PO4',...
        'PO8','O1','OZ','O2','IZ'};

    theta=zeros(1,64);
    radius=zeros(1,64);

    thetaMap=containers.Map(ch_list,theta);
    radiusMap=containers.Map(ch_list,radius);
    
    % Load 10-20 System (81 electrodes)
    locs_std_10_20=load('Standard_10-20_81ch.mat', 'locations');
    for i=1:81
        std_ch=locs_std_10_20.locations.labels{i};
        th=locs_std_10_20.locations.theta(i);
        rad=locs_std_10_20.locations.radius(i);

        thetaMap(std_ch)=th;
        radiusMap(std_ch)=rad;
    end

    ch_theta=values(thetaMap,ch_list);
    ch_radius=values(radiusMap,ch_list);

    locations_CH64= table(transpose(ch_list),...
        transpose(ch_theta),...
        transpose(ch_radius),...
        'VariableNames',{'labels','theta','radius'});
    %locations_CH64 = array2table(locations_CH64,'VariableNames',{'labels','theta','radius'});
    locations_CH64.theta=cell2mat(locations_CH64.theta);
    locations_CH64.radius=cell2mat(locations_CH64.radius);
end
