%% Topographical Plots Efficiency Indices
%%% Francesco Vincelli, 2020
warning off
    
% lev=LHM_CH_64_f1.local_efficiency_all;
% plot_topography(ch_list,lev,1,locs_filename);
% figure()
% title("NEW Topogaphical Plot");

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

    
%% Group datasets to be ploted
LHM_64_data = [LHM_CH_64_f1, LHM_CH_64_f2];
LHM_21_data = [LHM_CH_21_f1, LHM_CH_21_f2];
LHI_64_data = [LHI_CH_64_f1, LHI_CH_64_f2];
LHI_21_data = [LHI_CH_21_f1, LHI_CH_21_f2];
RHM_64_data = [RHM_CH_64_f1, RHM_CH_64_f2];
RHM_21_data = [RHM_CH_21_f1, RHM_CH_21_f2];
RHI_64_data = [RHI_CH_64_f1, RHI_CH_64_f2];
RHI_21_data = [RHI_CH_21_f1, RHI_CH_21_f2];

%% Set plottings arguments

% Left Hand Movement
keys_LHM_64={'plotType','freqs','channels','compare','figureName'};
values_LHM_64=["multiple","f1_f2","64","frequency","Left Hand Movement"];
args_LHM_64=containers.Map(keys_LHM_64,values_LHM_64);

keys_LHM_21={'plotType','freqs','channels','compare','figureName'};
values_LHM_21=["multiple","f1_f2","21","frequency","Left Hand Movement"];
args_LHM_21=containers.Map(keys_LHM_21,values_LHM_21);

% Left Hand Imagination
keys_LHI_64={'plotType','freqs','channels','compare','figureName'};
values_LHI_64=["multiple","f1_f2","64","frequency","Left Hand Imagination"];
args_LHI_64=containers.Map(keys_LHI_64,values_LHI_64);

keys_LHI_21={'plotType','freqs','channels','compare','figureName'};
values_LHI_21=["multiple","f1_f2","21","frequency","Left Hand Imagination"];
args_LHI_21=containers.Map(keys_LHI_21,values_LHI_21);

% Right Hand Movement
keys_RHM_64={'plotType','freqs','channels','compare','figureName',};
values_RHM_64=["multiple","f1_f2","64","frequency","Right Hand Movement"];
args_RHM_64=containers.Map(keys_RHM_64,values_RHM_64);

keys_RHM_21={'plotType','freqs','channels','compare','figureName',};
values_RHM_21=["multiple","f1_f2","21","frequency","Right Hand Movement"];
args_RHM_21=containers.Map(keys_RHM_21,values_RHM_21);

% Right Hand Imagination
keys_RHI_64={'plotType','freqs','channels','compare','figureName'};
values_RHI_64=["multiple","f1_f2","64","frequency","Right Hand Imagination"];
args_RHI_64=containers.Map(keys_RHI_64,values_RHI_64);

keys_RHI_21={'plotType','freqs','channels','compare','figureName'};
values_RHI_21=["multiple","f1_f2","21","frequency","Right Hand Imagination"];
args_RHI_21=containers.Map(keys_RHI_64,values_RHI_21);

%% Plot Efficiency Maps
efficiency_plots(LHM_64_data, args_LHM_64, ch_list_64);
efficiency_plots(LHM_21_data, args_LHM_21, ch_list_21);
pause(0.5)
efficiency_plots(LHI_64_data, args_LHI_64, ch_list_64);
efficiency_plots(LHI_21_data, args_LHI_21, ch_list_21);
pause(0.5)
efficiency_plots(RHM_64_data, args_RHM_64, ch_list_64);
efficiency_plots(RHM_21_data, args_RHM_21, ch_list_21);
pause(0.5)
efficiency_plots(RHI_64_data, args_RHI_64, ch_list_64);
efficiency_plots(RHI_21_data, args_RHI_21, ch_list_21);

function efficiency_plots(data, args, ch_list)
    plotType=args('plotType');
    freqs=args('freqs');
    channels=args('channels');
    compare=args('compare');
    figureName=args('figureName');
    
    pltKeys={'plotTitle','windowName','windowState','numPlots'};
    
    switch compare
        case 'frequency'
            fs=strsplit(freqs,'_');
            windowName=sprintf("%s: Efficiency Indices || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
            plotTitle=['Global/Local Efficiency | Frequency: f1=13',...
                'Global/Local Efficiency | Frequency: f1=16'];
            numPlots=2;
            windowState='maximized';
            
            pltValues=[plotTitle,windowName,windowState,numPlots];
            pltArgs=containers.Map(pltKeys,pltValues);
            multiple_maps(data,pltArgs, ch_list);
        
        case 'channels'
            fs=strsplit(freqs,'_');
            chs = strsplit(channels,'_');
            if size(fs,2)==1
                windowName=sprintf("%s: Efficiency Indices || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
                plotTitle=['Global/Local Efficiency | Channels: 64',...
                    'Global/Local Efficiency | Channels: 21'];
                numPlots=2;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots];
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_maps(data,pltArgs, ch_list);
            elseif size(fs,2)==2
                windowName=sprintf("%s: Efficiency Indices || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
                plotTitle=['Out/In/Tot-Degrees | Ch: 64 | f1=13',...
                    'Global/Local Efficiency | Ch: 64 | f2=16',...
                    'Global/Local Efficiency | Ch: 21 | f1=13',...
                    'Global/Local Efficiency | Ch: 21 | f2=16'];
                numPlots=4;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots];
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_maps(data,pltArgs, ch_list);
            end
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
            subplot(1,2,i)
            efficiency_map(data(i), ch_list);

            % Set plot title
            plt_title = plotTitle(1,len*idx+1:len*(idx+1));
            title(plt_title);
            idx=idx+1;
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