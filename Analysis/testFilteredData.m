function testFilteredData(fileList)

 for fileN = 1:size(fileList,2)
        
        loadData(fileList(fileN));
        
        % Generate a new file name to hold filtered data
        dcSettings = dataCzarSettings();
        load([dcSettings.dataCzarDir,'.dmIndex.mat']);
        file = dmIndex.files(fileList(fileN));
        sourceName = file.name;        
        newName = strrep(sourceName,'.mat','filt.mat');
        
        loadData(newName);
        
        [smoothX, wrappedX] = smoothUnwrap(data.X, daqParams.xOutputCal, 0);
        
        timeBase = getExpTime(size(wrappedX,2));
        
        figure();
        plot(timeBase,wrappedX,'b'); hold on;
        plot(timeBase,mod(filteredData.filtX,360),'r');
        
        figure();
        hist(filteredData.dX,1000);
        
        figure();
        plot(timeBase,data.LAmp - data.RAmp,'b'); hold on;
        plot(timeBase,filteredData.filtWBAdiff,'r');
        
        figure();
        hist(filteredData.filtdWBAdiff,100);
 end
 