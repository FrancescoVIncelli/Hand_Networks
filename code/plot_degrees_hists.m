%% Plot table of graph's degrees
%%% Francesco Vincelli, 2020


%% Right Hand Execution\Imagination Movement
data_CH64=[[LHM_CH_64_f1,LHI_CH_64_f1],
           [RHM_CH_64_f1,RHI_CH_64_f1],
           [LHM_CH_64_f2,LHI_CH_64_f2],
           [RHM_CH_64_f2,RHI_CH_64_f2]];
      
keys_CH64={'plotType','channels','freqs','compare','figureName','degs'};
values_CH64=["multiple","64","13_16","exec-imag","Hand Movement Execution/Imagination","tot"];
args_CH64=containers.Map(keys_CH64,values_CH64);

%% Left Hand Execution\Imagination Movement
data_CH21=[[LHM_CH_21_f1,LHI_CH_21_f1],
           [RHM_CH_21_f1,RHI_CH_21_f1],
           [LHM_CH_21_f2,LHI_CH_21_f2],
           [RHM_CH_21_f2,RHI_CH_21_f2]];
  
keys_CH21={'plotType','channels','freqs','compare','figureName','degs'};
values_CH21=["multiple","21","13_16","exec-imag","Hand Movement Execution/Imagination","tot"];
args_CH21=containers.Map(keys_CH21,values_CH21);

%% Left\Right Execution Movement
data_LRM=[[LHM_CH_64_f1,RHM_CH_64_f1],
          [LHM_CH_64_f2,RHM_CH_64_f2],
          [LHM_CH_21_f1,RHM_CH_21_f1],
          [LHM_CH_21_f2,RHM_CH_21_f2]];
  
keys_LRM={'plotType','channels','freqs','compare','figureName','dataIds','degs'};
values_LRM=["multiple","64_21","13_16","left-right","Left\Right Hand Movement Execution","LRM","tot"];
args_LRM=containers.Map(keys_LRM,values_LRM);

%% Left\Right Imagination Movement
data_LRI=[[LHI_CH_64_f1,RHI_CH_64_f1],
          [LHI_CH_64_f2,RHI_CH_64_f2],
          [LHI_CH_21_f1,RHI_CH_21_f1],
          [LHI_CH_21_f2,RHI_CH_21_f2]];
  
keys_LRI={'plotType','channels','freqs','compare','figureName','dataIds','degs'};
values_LRI=["multiple","64_21","13_16","left-right","Left\Right Hand Imagination Movement","LRI","tot"];
args_LRI=containers.Map(keys_LRI,values_LRI);

%% Plots
degrees_bargraphs(data_CH64,args_CH64);
pause(0.5);
degrees_bargraphs(data_CH21,args_CH21);
pause(0.5);
degrees_bargraphs(data_LRI,args_LRI);
pause(0.5);
degrees_bargraphs(data_LRM,args_LRM);

function degrees_bargraphs(data,args)
    plotType=args('plotType');
    compare=args('compare');
    figureName=args('figureName');
    
    channels=args('channels');
    freqs=args('freqs');
    degs=args('degs');
    
    pltKeys={'plotTitle','windowName','windowState','numPlots','compare','degs'};
    
    switch compare
        case 'exec-imag'
            fs=strsplit(freqs,'_');
            windowName=sprintf("%s: Graph nodes' degrees || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
            plotTitle=[sprintf('LH M-I | CH:%s | Freq: %s',channels,fs{1}),...
                sprintf('RH M-I | CH:%s | Freq: %s',channels,fs{1}),...
                sprintf('LH M-I | CH:%s | Freq: %s',channels,fs{2}),...
                sprintf('RH M-I | CH:%s | Freq: %s',channels,fs{2})];
            numPlots=4;
            windowState='maximized';

            pltValues=[plotTitle,windowName,windowState,numPlots,compare,degs];
            % size(pltValues)
            pltArgs=containers.Map(pltKeys,pltValues);
            multiple_degs_bargraphs(data,pltArgs);
        
        case 'left-right'
            chs = strsplit(channels,'_');
            fs=strsplit(freqs,'_');
            ids=args('dataIds');
            windowName=sprintf("%s: Graph nodes' degrees || Channels: (%s, %s) | Frequencies: (%s, %S)",figureName, chs{1},chs{2},fs{1},fs{2});
            plotTitle=[sprintf('%s | CH: %s | Freq: %s',ids,chs{1},fs{1}),...
                sprintf('%s | CH: %s | Freq: %s',ids,chs{1},fs{2}),...
                sprintf('%s | CH: %s | Freq: %s',ids,chs{2},fs{1}),...
                sprintf('%s | CH: %s | Freq: %s',ids,chs{2},fs{2})];
            numPlots=4;
            windowState='maximized';

            pltValues=[plotTitle,windowName,windowState,numPlots,compare,degs];
            % size(pltValues)
            pltArgs=containers.Map(pltKeys,pltValues);
            multiple_degs_bargraphs(data,pltArgs);
    end
            
            
            
end

function multiple_degs_bargraphs(data,args)
    % Get plot arguments
    plotTitle=args('plotTitle');
    n_plots = str2num(args('numPlots'));
    
    idx=0;
    len=size(plotTitle,2)/4;
    for i=1:n_plots
        % Set plot title
        plt_title = sprintf("%s",plotTitle(1,len*idx+1:len*(idx+1)));
        disp(plt_title);
        args('plotTitle')=plt_title;
        degrees_bars_comp(data(i,:),args);

        idx=idx+1;
    end
end

function b = degrees_bars_comp(data,args)
    % Get plot arguments
    windowName = args('windowName');
    windowState = args('windowState');
    plt_title=args('plotTitle');
    degs=args('degs');
    compare=args('compare');
    
    % Collect data
    switch degs
        case 'in'
            d1  = data(1).In_degrees;
            d2  = data(2).In_degrees;
        case 'out'
            d1 = data(1).Out_degrees;
            d2 = data(2).Out_degrees;
        case 'tot'
            d1    = data(1).Degrees;
            d2    = data(2).Degrees;
    end
    
    % Set histogram data and categorical labels
    N = size(d1,2);
    nodes_ids=cell(1,N);
    vals=zeros(N,2);
    for i=1:N
        vals(i,1)=d1(i);
        vals(i,2)=d2(i);
        nodes_ids{i}=num2str(i);
    end
    
    X = categorical(nodes_ids);
    X = reordercats(X,nodes_ids);
    
    % Plot histogram
    fig= figure('Name',windowName,'WindowState',windowState);
    b = bar(X, vals);
    
    xlabel("Nodes ids");
    ylabel("Nodes counts");
    
    if strcmp(compare,'exec-imag')
        legend('Execution','Imagination',...
            'Location','south','Orientation','vertical');
    elseif strcmp(compare,'left-right')
        legend('Left Hand','Right Hand',...
            'Location','south','Orientation','vertical');
    end
    
    % b(1,1).EdgeColor='b';
    % b(1,2).EdgeColor='r';
    
    title(plt_title);
end

function b = density_bars(data)
    
    % Collect data
    dens_L = data.Left_Hemis_Density;
    dens_R = data.Right_Hemis_Density;

    % Set categorical lables
    X = categorical({'Left Density','Right Density'});
    X = reordercats(X,{'Left Density','Right Density'});
    
    % Create bar graph
    b = bar(X,[dens_L, dens_R],'FaceColor','flat','LineWidth',1.5);
    
    xtips = b.XEndPoints;
    ytips = b.YEndPoints;
    labels = string(b.YData);
    text(xtips,ytips,labels,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom');
end