%% Density plots


%dataset = [LHM_CH_64_f1, LHM_CH_21_f1];
%density_bars(LHM_CH_64_f1);

%keys={'windowName','windowState','plotTitle','numPlots'}

keys={'plotType','freqs','channels','compare','figureName','dataIds'};
%values=["multiple","13_16","64","frequency","Hand Movement Execution/Imagination"];
values=["multiple","13_16","64_21","channels","Hand Movement Execution/Imagination","LHM_RHM"];
args=containers.Map(keys,values);

%% All 64-Channels data
dataCH64=[[LHM_CH_64_f1,LHM_CH_64_f2],
          [RHM_CH_64_f1,RHM_CH_64_f2],
          [LHI_CH_64_f1,LHI_CH_64_f2],
          [RHI_CH_64_f1,RHI_CH_64_f2]];
      
keysCH64={'plotType','freqs','channels','compare','figureName',};
valuesCH64=["multiple","13_16","64","frequency","Hand Movement Execution/Imagination"];
argsCH64=containers.Map(keysCH64,valuesCH64);

%% All 21-Channels data
dataCH21=[[LHM_CH_21_f1,LHM_CH_21_f2],
          [RHM_CH_21_f1,RHM_CH_21_f2],
          [LHI_CH_21_f1,LHI_CH_21_f2],
          [RHI_CH_21_f1,RHI_CH_21_f2]];
  
keysCH21={'plotType','freqs','channels','compare','figureName'};
valuesCH21=["multiple","13_16","21","frequency","Hand Movement Execution/Imagination"];
argsCH21=containers.Map(keysCH21,valuesCH21);

%% All f1-Frequency data (f1=13)
dataFs13=[[LHM_CH_64_f1,LHM_CH_21_f1],
          [RHM_CH_64_f1,RHM_CH_21_f1],
          [LHI_CH_64_f1,LHI_CH_21_f1],
          [RHI_CH_64_f1,RHI_CH_21_f1]];
  
keysFs13={'plotType','freqs','channels','compare','figureName'};
valuesFs13=["multiple","13","64_21","channels","Hand Movement Execution/Imagination"];
argsFs13=containers.Map(keysFs13,valuesFs13);

%% All f2-Frequency data (f2=16)
dataFs16=[[LHM_CH_64_f2,LHM_CH_21_f2],
          [RHM_CH_64_f2,RHM_CH_21_f2],
          [LHI_CH_64_f2,LHI_CH_21_f2],
          [RHI_CH_64_f2,RHI_CH_21_f2]];
  
keysFs16={'plotType','freqs','channels','compare','figureName'};
valuesFs16=["multiple","16","64_21","channels","Hand Movement Execution/Imagination"];
argsFs16=containers.Map(keysFs16,valuesFs16);

%% Plots
density_bargraphs(dataCH64,argsCH64);
pause(0.5);
density_bargraphs(dataCH21,argsCH21);
pause(0.5);
density_bargraphs(dataFs13,argsFs13);
pause(0.5);
density_bargraphs(dataFs16,argsFs16);

function density_bargraphs(data,args)
    plotType=args('plotType');
    freqs=args('freqs');
    channels=args('channels');
    compare=args('compare');
    figureName=args('figureName');
    
    pltKeys={'plotTitle','windowName','windowState','numPlots','compare'};
    
    switch compare
        case 'frequency'
            fs=strsplit(freqs,'_');
            chs=strsplit(channels,'_');
            if size(chs,2)==1
                windowName=sprintf("%s: Hemispheres' densities || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
                plotTitle=[sprintf('LHM-CH-%s | Freqs: (%s,%s)',channels,fs{1},fs{2}),...
                    sprintf('RHM-CH-%s | Freqs: (%s,%s)',channels,fs{1},fs{2}),...
                    sprintf('LHI-CH-%s | Freqs: (%s,%s)',channels,fs{1},fs{2}),...
                    sprintf('RHI-CH-%s | Freqs: (%s,%s)',channels,fs{1},fs{2})];
                numPlots=4;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots,compare];
                size(pltValues)
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_bargraphs(data,pltArgs);
                
            elseif size(chs,2)==2
                dataIds=args('dataIds');
                ids=strsplit(dataIds,'_');
                windowName=sprintf("%s: Hemispheres' densities || Channels: %s | Frequency: (%s, %s)",figureName, chs{1},fs{2},fs{1});
                plotTitle=[sprintf('%s-CH-%s | Channels: (%s,%s)',ids{1},chs{1},fs{1},fs{2}),...
                    sprintf('%s-CH-%s | Freqs: (%s,%s)',ids{1},chs{1},fs{1},fs{2}),...
                    sprintf('%s-CH-%s | Freqs: (%s,%s)',ids{2},chs{1},fs{1},fs{2}),...
                    sprintf('%s-CH-%s | Freqs: (%s,%s)',ids{2},chs{1},fs{1},fs{2})];
                numPlots=4;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots,compare];
                size(pltValues)
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_bargraphs(data,pltArgs);
            end
        
        case 'channels'
            fs=strsplit(freqs,'_');
            chs = strsplit(channels,'_');
            if size(fs,2)==1
                windowName=sprintf("%s: Hemispheres' densities || Channels: (%s, %s) | Frequency: %s",figureName, chs{1},chs{2},fs{1});
                plotTitle=[sprintf('LHM-Freq-%s | Channels: (%s,%s)',fs{1},chs{1},chs{2}),...
                    sprintf('RHM-Freq-%s | Channels: (%s,%s)',fs{1},chs{1},chs{2}),...
                    sprintf('LHI-Freq-%s | Channels: (%s,%s)',fs{1},chs{1},chs{2}),...
                    sprintf('RHI-Freq-%s | Channels: (%s,%s)',fs{1},chs{1},chs{2})];
                numPlots=4;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots,compare];
                size(pltValues)
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_bargraphs(data,pltArgs);
            elseif size(fs,2)==2
                dataIds=args('dataIds');
                ids=strsplit(dataIds,'_');
                windowName=sprintf("%s: Hemispheres' densities || Channels: %s | Frequencies: (%s - %s)",figureName, channels,fs{1},fs{2});
                plotTitle=[sprintf('%s-Freq-%s | Channels: (%s,%s)',ids{1},fs{1},chs{1},chs{2}),...
                    sprintf('%s-Freq-%s | Channels: (%s,%s)',ids{1},fs{2},chs{1},chs{2}),...
                    sprintf('%s-Freq-%s | Channels: (%s,%s)',ids{2},fs{1},chs{1},chs{2}),...
                    sprintf('%s-Freq-%s | Channels: (%s,%s)',ids{2},fs{2},chs{1},chs{2})];
                numPlots=4;
                windowState='maximized';

                pltValues=[plotTitle,windowName,windowState,numPlots,compare];
                size(pltValues)
                pltArgs=containers.Map(pltKeys,pltValues);
                multiple_bargraphs(data,pltArgs);
            end
    end
            
            
            
end

function multiple_bargraphs(data,args)
    % Get plot arguments
    windowName=args('windowName');
    windowState=args('windowState');
    plotTitle=args('plotTitle');
    n_plots = str2num(args('numPlots'));
    compare=args('compare');
    
    fig = figure('Name',windowName,'WindowState',windowState);
    
    if n_plots==2
        % Two-columns plot
        idx=0;
        len=size(plotTitle,2)/2;
        for i=1:n_plots
            subplot(1,2,i)
            density_bars_comp(data(i,: ),compare);

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
            density_bars_comp(data(i,:),compare);
            
            % Set plot title
            plt_title = plotTitle(1,len*idx+1:len*(idx+1));
            title(plt_title);
            idx=idx+1;
        end
    end
end

function b = density_bars_comp(data,compare)
    
%     if size(data,2) ~= 4
%        error(...
%            sprintf("Error in 'density_bars_comp'\nArgument 'data' must have 'size(:,2)==2'"));
%     end
    
    % Collect data
    dens1_L = data(1).Left_Hemis_Density;
    dens1_R = data(1).Right_Hemis_Density;

    dens2_L = data(2).Left_Hemis_Density;
    dens2_R = data(2).Right_Hemis_Density;
    
    % Set categorical lables
    if strcmp(compare,'frequency')
        X = categorical({'Frequency: f1=13','Frequency: f2=16'}); 
        X = reordercats(X,{'Frequency: f1=13','Frequency: f2=16'});
    elseif strcmp(compare,'channels')
        X = categorical({'Channels: 64','Channels: 21'});
        X = reordercats(X,{'Channels: 64','Channels: 21'});
    end
    
    b = bar(X,[dens1_L, dens1_R; dens2_L, dens2_R],'FaceColor','flat','LineWidth',1.5);
    legend('Left Hemisphere Density','Right Hemisphere Density',...
        'Location','south','Orientation','vertical');
    
    b(1,1).EdgeColor='b';
    b(1,2).EdgeColor='r';

    xtips1 = b(1).XEndPoints;
    ytips1 = b(1).YEndPoints;
    labels1 = string(b(1).YData);
    text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom');

    xtips2 = b(2).XEndPoints;
    ytips2 = b(2).YEndPoints;
    labels2 = string(b(2).YData);
    text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
        'VerticalAlignment','bottom')
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