% batchAnalyzeRTTFhalves.m

clear all;

settings = tfSettings();


comment = 'Lasered wedge, MeS @ -2';
fileList = {...

% [settings.dataDir,'RTTF110718-111618.mat'],...
% [settings.dataDir,'RTTF110718-125230.mat'],...
% [settings.dataDir,'RTTF110718-132622.mat'],...
% [settings.dataDir,'RTTF110718-140225.mat'],...
% [settings.dataDir,'RTTF110718-144010.mat'],...

% [settings.dataDir,'RTTF110725-135227.mat'],...
% [settings.dataDir,'RTTF110725-142627.mat'],...
% [settings.dataDir,'RTTF110725-151112.mat'],...
% [settings.dataDir,'RTTF110725-154735.mat'],...
% [settings.dataDir,'RTTF110725-162439.mat'],...
% [settings.dataDir,'RTTF110725-165733.mat'],...
% [settings.dataDir,'RTTF110725-174232.mat'],...
% [settings.dataDir,'RTTF110726-140934.mat'],...
% [settings.dataDir,'RTTF110726-152347.mat'],...

[settings.dataDir,'RTTF110804-101419.mat'],...
[settings.dataDir,'RTTF110804-124036.mat'],...
[settings.dataDir,'RTTF110804-133200.mat'],...
[settings.dataDir,'RTTF110804-141209.mat'],...
[settings.dataDir,'RTTF110804-144824.mat'],...
[settings.dataDir,'RTTF110804-152206.mat'],...
[settings.dataDir,'RTTF110804-155425.mat'],...


     };



PIwindow = [0,180]; % In JSB(right-hand-rule) coords

smoothingWindow = 4; % Boxcar window, in seconds
        
tOffset = -.129; % Timing offset
rateError = .36; % Correction for DAQ clock
colorList = ['k','g','b','g','b','y','c','b','m','k','r','g','y','c'];



for file=1:size(fileList,2)
    
    
    load(fileList{file});
    nSamples = size(data.LAmp,1);
    data.time = ((1:nSamples) ./ (daqParams.SampleRate + rateError)) + tOffset;
    [data.smoothX, data.wrappedX] = smoothUnwrap(data.X, daqParams.xOutputCal, 0);
    
    sampleBounds = round(histogramBounds * daqParams.SampleRate) + 1;
    numHist = size(histogramBounds,1);
    numParts = size(histogramBounds,2);

    for i=numHist:-1:1
        partsList = [];
        for j=1:2:numParts
            partsList = cat(2, partsList, sampleBounds(i,j):sampleBounds(i,j+1));
        end

        if (file == 1)
        	Xtotal{i} = data.wrappedX(partsList);
        else
        	Xtotal{i} = cat(2,Xtotal{i},data.wrappedX(partsList));
        end
        
        count = 0;
        for j = 1:size(PIwindow,1)
            count = count + nnz((data.wrappedX(partsList) > PIwindow(j,1)) ...
                & (data.wrappedX(partsList) <= PIwindow(j,2)));
        end
        total = size(data.wrappedX(partsList),2);
        disp(['T: ',num2str(total)]);
        disp(['C: ',num2str(count)]);
        PI(i, file) = (2*count - total)/total;
        disp(  (2*count - total)/total);
    end 
     
    disp(['Analyzed file ',num2str(file),'.']);
end

%     %% Plot the angle histogram
%  
figure();

sampleBounds = round(histogramBounds * daqParams.SampleRate) + 1;
numHist = size(histogramBounds,1);
numParts = size(histogramBounds,2);

clear('bins','n');

biggestYLim = 0;
for i=numHist:-1:1
%     partsList = [];
%     for j=1:2:numParts
%         partsList = cat(2, partsList, sampleBounds(i,j):sampleBounds(i,j+1));
%     end
%     [bins(i,:), n(i,:)] = rose((Xtotal{i}+1.8)*2*pi/360,96); 
%     %was smoothX
%     %[n(i,:), bins(i,:)] = hist(data.wrappedX(partsList)*2*pi/360,96);
%     maxN(i) = max(n(i,:));
% end
% 
% [B, IX] = sort(maxN,'descend');
% totMax = max(maxN);
% 
% for plotNum = 1:size(histogramBounds,1)
%     subplot(2,( size(histogramBounds,1)), plotNum);
%     for i=plotNum
%         polar(bins(i,:),n(i,:)./maxN(plotNum),colorList(i));
%         hold on;
%     end
%     lims = ylim();
%     maxR = 1;
% 
% 
%     for i=1:size(trialStructureList,1)
%         time(i) = trialStructureList{i,1};
%         laser(i,:) = trialStructureList{i,3}; 
%         odor1(i,:) = trialStructureList{i,4}; 
%         odor2(i,:) = trialStructureList{i,5}; 
%     end
%     for i = 2:size(trialStructureList,1)
%         for j=1:16
%             if (  bitand( hex2dec(laser(i-1,:)), bitshift(1,j-1))  > 0)
%                 interval = -2*pi/16;
%                 angles = (j-1)*interval:interval/15:j*interval;
%                 Rmaxes = 1*ones(16,1);
%                 [X, Y] = pol2cart([(j-1)*interval angles j*interval],[0 Rmaxes' 0]);
%                 fill(X, Y, [1 .7 .7],'EdgeColor','none','FaceAlpha',.5);
%                 hold on;
%             end
%             if (  bitand( hex2dec(odor1(i-1,:)), bitshift(1,j-1))  > 0)
%                 interval = -2*pi/16;
%                 angles = (j-1)*interval:interval/15:j*interval;
%                 Rmaxes = .8*ones(16,1);
%                 [X, Y] = pol2cart([(j-1)*interval angles j*interval],[0 Rmaxes' 0]);
%                 fill(X, Y, [.7 1 .7],'EdgeColor','none','FaceAlpha',.5);
%                 hold on;
%             end
%             if (  bitand( hex2dec(odor2(i-1,:)), bitshift(1,j-1))  > 0)
%                 interval = -2*pi/16;
%                 angles = (j-1)*interval:interval/15:j*interval;
%                 Rmaxes = .6*ones(16,1);
%                 [X, Y] = pol2cart([(j-1)*interval angles j*interval],[0 Rmaxes' 0]);
%                 fill(X, Y, [.7 .7 1],'EdgeColor','none','FaceAlpha',.5);
%                 hold on;
%             end
%         end
%     end
% 
%     hline = findobj(gca,'Type','line');
%     set(hline,'LineWidth',1);
%     axis equal;
%     %title(comment);
    
    
    % Plot Linear Histograms
%     boxCoords = [-45 -45 45 45]; % front
%     % boxCoords = [45 45 135 135]; % right box
%     % boxCoords = [-180 -180 -90 -90]; % front
%     boxCoords2 = [90 90 180 180]; % front
%     boxCoords3 = [-90 -90 90 90]; % front
    for plotNum = 1:size(histogramBounds,1)
        transX = -Xtotal{plotNum} + 90;
        outBounds = (transX < -180) | (transX > 90);
        transX(outBounds) = NaN;
        trans2X = -Xtotal{plotNum} + 90 + 360;
        out2Bounds = (trans2X > 180) | (trans2X <= 90);
        trans2X(out2Bounds) = NaN;
        reformattedTotal = [transX,trans2X];
        subplot(2,size(histogramBounds,1), plotNum);
        %figure(plotNum);
        hold on;
%         if (plotNum == 2) || (plotNum == 4)
%             lim = ylim();
%             block = fill(boxCoords,[lim(1) lim(2) lim(2) lim(1)],[.6 1 .6] ,'EdgeColor','none','FaceAlpha',1);
%             %block2 = fill(boxCoords2,[lim(1) lim(2) lim(2) lim(1)],[.6 1 .6] ,'EdgeColor','none','FaceAlpha',1);
%         elseif (plotNum == 3) || (plotNum == 5)
%             lim = ylim();
%             block = fill(boxCoords,[lim(1) lim(2) lim(2) lim(1)],[.6 .6 1] ,'EdgeColor','none','FaceAlpha',1);
%         end
        hist(reformattedTotal,-180:3.75:180);
        h = findobj(gca,'Type','patch');
        set(h,'FaceColor','b','EdgeColor','none')
        lims = ylim();
        if (lims(2) > biggestYLim)
            biggestYLim = lims(2);
        end
%          h = findobj(gca,'Type','patch');
%          set(h,'FaceColor',[0 0 .4],'EdgeColor','none')
%          if (plotNum == 2) || (plotNum == 4) || (plotNum == 3) || (plotNum == 5)
%              set(block,'FaceColor',[.6 1 .6]);
%          elseif (plotNum == 3) || (plotNum == 5)
%              set(block,'FaceColor',[.6 .6 1]);
%              %set(block2,'FaceColor',[.6 .6 1]);
%          end
%          if plotNum == 2
%              title('Odor Tube in Front - ACV^0');
%          end
        xlim([-180 180]);
        %ylim([0 60000]);
        %ylim([0 80000]);
        set(gca,'XTick',[-180 0 180],'TickDir','out');
        set(gca,'YTickLabel','','TickDir','out');
                
    end
    
end

for plotNum = 1:size(histogramBounds,1)
     subplot(2,size(histogramBounds,1), plotNum);
     ylim([0 biggestYLim]);
     
     subplot(2,size(histogramBounds,1),plotNum + size(histogramBounds,1));
     scatter(ones(size(PI(plotNum,:),2),1)',PI(plotNum,:));
     hold on;
     plot(xlim(),[0 0],'k');
     ylim([-1 1]);
     ylabel('PI');
     set(gca,'XTick',[],'TickDir','out');
     
end

for plotNum = [4,5,7,8]
    subplot(2,size(histogramBounds,1), plotNum);
    set(gca,'Color',[1 .8 .8]);
    subplot(2,size(histogramBounds,1),plotNum + size(histogramBounds,1));
    set(gca,'Color',[1 .8 .8]);
end

subplot(2,size(histogramBounds,1), floor(size(histogramBounds,1)/2));
title(comment);


        set(gcf, 'Color', 'white');
        set(gcf, 'InvertHardcopy','off');
        set(gcf,'Units','pixels');
        scnsize = get(0,'ScreenSize');
        set(gcf,'Position',[1 1 scnsize(3) scnsize(4)]);
        set(gcf, 'PaperUnits', 'inches');
        set(gcf, 'PaperSize', [11 8.5])
        set(gcf, 'PaperPosition', [0 0 11 8.5]);
            filenameOut = [settings.dataDir,'Crunch-',comment,'.pdf'];  
        print(gcf, '-dpdf',filenameOut);

        
out = 1;





 
 