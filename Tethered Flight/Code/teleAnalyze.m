% teleAnalyze.m



filesToBunch = {'../Data/RTTF100914-153727.mat', ...
                 };


%filesToBunch = {'../Data/RTTF100806-164955.mat'};
    
plotTitle = '';
odorLocation = 90;
patternOffset = 11.25;
plotDuration = 30;


% Alt Train
plotAt = 10 + (0:5)*30;

%plotAt = (0:11)*30 + 10 + 6*30 + 11*30;


tOffset = -.129; % Timing offset
rateError = .36; % Correction for DAQ clock

numFiles = size(filesToBunch,2);
numTraces = size(plotAt,2);

figure(2);
%subplot(1,2,1);

for file = 1:numFiles;
    
    disp(['File: ',num2str(file)]);
    
    load(filesToBunch{file});
    nSamples = size(data.LAmp,1);
    data.time = ((1:nSamples) ./ (daqParams.SampleRate + rateError)) + tOffset;

    for trace = 1:numTraces
        
        disp(['Trace: ',num2str(trace)]);
        
        stPlot = plotAt(trace);
        endPlot = stPlot + plotDuration;
        timesRelStart = abs(data.time - stPlot);
        timesRelEnd = abs(data.time - endPlot);
        [mins, stSample] = min(timesRelStart);
        [mins, endSample] = min(timesRelEnd);
        
        [smoothX,wrappedX] = smoothUnwrap(data.X, daqParams.xOutputCal, patternOffset); 
        dFromCenter = abs(wrapTo180(wrappedX(stSample:endSample) - odorLocation));
        
        plotList((file-1)*numTraces + trace, 1:(endSample - stSample + 1)) = dFromCenter(:);
        
        plot(data.time(1:size(dFromCenter,2)),dFromCenter);
        hold on;
    end
end

avgTrace = mean(plotList);
plot(data.time(1:size(avgTrace,2)), avgTrace,'r','LineWidth',2);
line([0 20],[90 90],'Color','g');
xlim([0 plotDuration]);
ylim([0 180]);
xlabel('Time (sec)')
ylabel('Angle from pattern center');
title(plotTitle);

figure(3);
%subplot(1,2,2);
plotAt = (0:23)*30 + 190;
numTraces = size(plotAt,2);
wholeDataX = 0;
wholeDataT = 0;
wholeDataD = 0;
for file = 1:numFiles;
    
    disp(['File: ',num2str(file)]);
    
    load(filesToBunch{file});
    nSamples = size(data.LAmp,1);
    data.time = ((1:nSamples) ./ (daqParams.SampleRate + rateError)) + tOffset;

    for trace = 1:numTraces
        
        disp(['Trace: ',num2str(trace)]);
        
        stPlot = plotAt(trace);
        endPlot = stPlot + plotDuration;
        timesRelStart = abs(data.time - stPlot);
        timesRelEnd = abs(data.time - endPlot);
        [mins, stSample] = min(timesRelStart);
        [mins, endSample] = min(timesRelEnd);
        
        [smoothX,wrappedX] = smoothUnwrap(data.X, daqParams.xOutputCal, patternOffset); 
        dFromCenter = abs(wrapTo180(wrappedX(stSample:endSample) - odorLocation));
        
        plotList((file-1)*numTraces + trace, 1:(endSample - stSample + 1)) = dFromCenter(:);
        wholeDataX = cat(2,wholeDataX, wrappedX(stSample:endSample));
        wholeDataD = cat(2,wholeDataD, dFromCenter);
        wholeDataT = cat(2,wholeDataT, data.time(1:size(dFromCenter,2)));
        plot(data.time(1:size(dFromCenter,2)),dFromCenter);
        hold on;
    end
end

avgTrace = mean(plotList);
plot(data.time(1:size(avgTrace,2)), avgTrace,'r','LineWidth',2);
line([0 20],[90 90],'Color','g');
xlim([0 plotDuration]);
ylim([0 180]);
xlabel('Time (sec)')
ylabel('Angle from pattern center');
title(plotTitle);

figure();
N = hist3([wholeDataT',wholeDataD'],{[0:.1:30],[0:3.75:180]});   
myMap = hot;
colormap(hot);
h = pcolor( N');
set(h,'EdgeColor','none');
% colorbar;
set(gca,'XTick',[0: 100 : 300]);
set(gca,'YTick',[0 :4:48]);
set(gca,'XTickLabel',[0: 10 : 30]);
set(gca,'YTickLabel',[0 :15:180]);
xlabel('Time (sec)');
ylabel('Angle from non-laser');

figure();
N = hist3([wholeDataT',wholeDataX'],{[0:.1:30],[0:3.75:360]});   
myMap = hot;
colormap(hot);
h = pcolor( N');
set(h,'EdgeColor','none');
% colorbar;
set(gca,'XTick',[0: 100 : 300]);
set(gca,'YTick',[0 :4:96]);
set(gca,'XTickLabel',[0: 10 : 30]);
set(gca,'YTickLabel',[0 :15:360]);
xlabel('Time (sec)');
ylabel('Arena angle');





        
        
        