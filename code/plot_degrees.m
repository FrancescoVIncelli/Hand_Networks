%% AIM3 - Plot tables of graphs' degrees


%% Group datasets to be ploted
LHM_data = [LHM_CH_64_f1, LHM_CH_64_f2, LHM_CH_21_f1, LHM_CH_21_f2];
LHI_data = [LHI_CH_64_f1, LHI_CH_64_f2, LHI_CH_21_f1, LHI_CH_21_f2];
RHM_data = [RHM_CH_64_f1, RHM_CH_64_f2, RHM_CH_21_f1, RHM_CH_21_f2];
RHI_data = [RHI_CH_64_f1, RHI_CH_64_f2, RHI_CH_21_f1, RHI_CH_21_f2];


%% Set plottings arguments

% Left Hand Movement
keys_LHM={'plotType','freqs','channels','compare','figureName'};
values_LHM=["multiple","f1_f2","64_21","channels","Left Hand Movement"];
args_LHM=containers.Map(keys_LHM,values_LHM);

% Left Hand Imagination
keys_LHI={'plotType','freqs','channels','compare','figureName'};
values_LHI=["multiple","f1_f2","64_21","channels","Left Hand Imagination"];
args_LHI=containers.Map(keys_LHI,values_LHI);

% Right Hand Movement
keys_RHM={'plotType','freqs','channels','compare','figureName'};
values_RHM=["multiple","f1_f2","64_21","channels","Right Hand Movement"];
args_RHM=containers.Map(keys_RHM,values_RHM);

% Right Hand Imagination
keys_RHI={'plotType','freqs','channels','compare','figureName'};
values_RHI=["multiple","f1_f2","64_21","channels","Right Hand Imagination"];
args_RHI=containers.Map(keys_RHI,values_RHI);


%% Plot tables
degrees_tables(LHM_data, args_LHM);
pause(0.5)
degrees_tables(LHI_data, args_LHI);
pause(0.5)
degrees_tables(RHM_data, args_RHM);
pause(0.5)
degrees_tables(RHI_data, args_RHI);

function degrees_tables(data,args)
    %%% Written by : Francesco Vincelli
	%     
    % @params
    %         data:      List of Binary PDC Matrices
    %         args:      Plotting arguments in a containers.Map format
    %                    Map(keysSet, valuesSet)
    % @return
    %         Combinations of table plots for listing and comparisons of
    %         Degrees indices for the input data
    %
    
    plotType=args('plotType');
    freqs=args('freqs');
    channels=args('channels');
    compare=args('compare');
    figureName=args('figureName');
    
    pltKeys={'plotTitle','windowName','windowState','numPlots'};
    
    switch compare
        % Compare data grouping by frequency band
        case 'frequency'
            fs=strsplit(freqs,'_');
            windowName=sprintf("%s: nodes'degrees || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
            plotTitle=['Out/In/Tot-Degrees | Frequency: f1=13',...
                'Out/In/Tot-Degrees | Frequency: f1=16'];
            numPlots=2;
            windowState='maximized';
            
            pltValues=[plotTitle,windowName,windowState,numPlots];
            pltArgs=containers.Map(pltKeys,pltValues);
            multiple_table(data,pltArgs);
        
        % Compare data grouping by channels
        case 'channels'
            fs=strsplit(freqs,'_');
            chs = strsplit(channels,'_');
            if size(fs,2)==1
                windowName=sprintf("%s: nodes'degrees || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
                plotTitle=['Out/In/Tot-Degrees | Channels: 64',...
                    'Out/In/Tot-Degrees | Channels: 21'];
                numPlots=2;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots];
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_table(data,pltArgs);
            elseif size(fs,2)==2
                windowName=sprintf("%s: nodes'degrees || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
                plotTitle=['Out/In/Tot-Degrees | Ch: 64 | f1=13',...
                    'Out/In/Tot-Degrees | Ch: 64 | f2=16',...
                    'Out/In/Tot-Degrees | Ch: 21 | f1=13',...
                    'Out/In/Tot-Degrees | Ch: 21 | f2=16'];
                numPlots=4;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots];
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_table(data,pltArgs);
            end
    end
            
            
            
end


function multiple_table(data,args)
    %%% Written by : Francesco Vincelli
    %
    % @params
    %         data:     List of PDC binary matrices
    %         args:     Plotting argument for graphic and writing
    %                   formatting
    % @return
    %         Manages multiple tabular subplots in a single figure
    %
    
    % Get plot arguments
    windowName=args('windowName');
    windowState=args('windowState');
    plotTitle=args('plotTitle');
    n_plots = str2num(args('numPlots'));
    
    fig = figure('Name',windowName,'WindowState',windowState);
    
    if n_plots==2
        % Two-columns plot
        idx=0;
        len=size(plotTitle,2)/2;
        for i=1:n_plots
           t = degs_table(data(i));
           uit = uitable('Parent',fig,'Data',t{:,:},'ColumnWidth', {110,110,110},...
                    'ColumnName',t.Properties.VariableNames,'RowName',...
                    t.Properties.RowNames,'Units','Normalized');
                
           % Remove side rule labels and add x,y lables
            set(subplot(1,2,i),'yTick',[]);
            set(subplot(1,2,i),'xTick',[]);
            xlabel('Degrees');
            ylabel('Nodes ids');

            % Set table position in figure window
            pos = get(subplot(1,2,i),'position');
            set(uit,'position',pos);

            % Set plot title
            plt_title = plotTitle(1,len*idx+1:len*(idx+1));
            title(plt_title);
            idx=idx+1;
        end
    else
        idx=0;
        len=size(plotTitle,2)/4;
        for i=1:n_plots
            t = degs_table(data(i));
           uit = uitable('Parent',fig,'Data',t{:,:},'ColumnWidth', {110,110,110},...
                    'ColumnName',t.Properties.VariableNames,'RowName',...
                    t.Properties.RowNames,'Units','Normalized');
                
           % Remove side rule labels and add x,y lables
            set(subplot(2,2,i),'yTick',[]);
            set(subplot(2,2,i),'xTick',[]);
            xlabel('Degrees');
            ylabel('Nodes ids');

            % Set table position in figure window
            pos = get(subplot(2,2,i),'position');
            set(uit,'position',pos);

            % Set plot title
            plt_title = plotTitle(1,len*idx+1:len*(idx+1));
            title(plt_title);
            idx=idx+1;
        end
    end
end

function single_table(data,args)
    %%% Written by : Francesco Vincelli
    %
    % @params
    %         data:     List of PDC binary matrices
    %         args:     Plotting argument for graphic and writing
    %                   formatting
    % @return
    %         Suitable formatting of tabular plot using plotting arguments
    %         in 'args' input parameter
    %
    
    % Get plot arguments
    windowName=args('windowName');
    windowState=args('windowState');
    plotTitle=args('plotTitle');
    
    fig = figure('Name',windowName,'WindowState',windowState);
    
    t = degs_table(data);
    uit = uitable('Parent',fig,'Data',t{:,:},'ColumnWidth', {110,110,110},...
                    'ColumnName',t.Properties.VariableNames,'RowName',...
                    t.Properties.RowNames,'Units','Normalized');
    
    % Remove side rule labels and add x,y lables
    set(subplot(1,1,1),'yTick',[]);
    set(subplot(1,1,1),'xTick',[]);
    xlabel('Degrees');
    ylabel('Nodes ids');
    
    % Set table position in figure window
    pos = get(subplot(1,1,1),'position');
    set(uit,'position',pos);
    
    % Set plot title
    title(plotTitle);
end

function t = degs_table(data)
    %%% Written by : Francesco Vincelli
    %
    % @params
    %         data:   PDC binary matrix
    
    % @return
    %         Plot a table containing In/Out/Total nodes' degrees for the
    %         input data
    %
    
    degs = data.Degrees;
    in_degs = data.In_degrees;
    out_degs = data.Out_degrees;

    % Columns names
    columns = {'Out-degrees';'In-degrees';'Total-degrees'};

    % Rows names
    N = size(degs,2); nodes_ids = cell(1,N);
    for i=1:N
        id = sprintf('{g_%d}',i);
        nodes_ids{i} = id;
    end

    A = [transpose(out_degs),transpose(in_degs),transpose(degs)];
    t = array2table(A, 'VariableNames',columns,'RowNames',nodes_ids);
end
