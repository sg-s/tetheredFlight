% batchAnalyzeRTTFSeries.m

fileList = {'../Data/Jul16/RTTF100716-105943.mat', ...
            '../Data/Jul16/RTTF100716-112325.mat', ...
            '../Data/Jul16/RTTF100716-115659.mat', ...
            '../Data/Jul16/RTTF100716-132452.mat', ...
            '../Data/Jul16/RTTF100716-135907.mat', ...
            '../Data/Jul16/RTTF100716-155637.mat', ...
            '../Data/Jul16/RTTF100716-141642.mat', ...
            '../Data/Jul16/RTTF100716-143428.mat', ...
            '../Data/Jul16/RTTF100716-144716.mat', ...
            '../Data/Jul16/RTTF100716-150104.mat', ...
            '../Data/Jul16/RTTF100716-161303.mat', ...
            '../Data/Jul16/RTTF100716-162920.mat', ...
            '../Data/Jul16/RTTF100716-164648.mat', ...
            };
  
for file = 1:size(fileList,2)
    
    analyzeRTTF(fileList{file},'ACV 10^0');
    close all;
    
    disp(['Wrote file #',num2str(file)]);
    
end