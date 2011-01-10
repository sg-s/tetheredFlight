
% heisenberg.m

% Constants
global ts;

center = 0;

% Format: {time, visStim} 
%          [Mode, K0, K1, K2]
visStim0 = [1, 0,  0, center];
visStimN = [1, 0, -1, center];
LaserOn  = 'c3c3';
LaserOff = '0000';
olf1 = '0000';
olf2 = '0000';

histogramBounds = [1,1*120;1*120,2*120;2*120,3*120;3*120,4*120;4*120,5*120;5*120,6*120;6*120,7*120;7*120,8*120;8*120,9*120];
colorsOff = 'ardSetColors(0,0);';
colorsOn =  'ardSetColors(0,2);';

trialStructureList = [...
        {0,        visStimN, LaserOff, '0000','0000',''};...     %nb. First line is initial settingss
        {1*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {1*120+1,    visStimN, LaserOff, '0000','0000',colorsOn};...
                {2*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {2*120+1,    visStimN, LaserOn, '0000','0000',colorsOn};...
                {3*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {3*120+1,    visStimN, LaserOn, '0000','0000',colorsOn};...
                {4*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {4*120+1,    visStimN, LaserOff, '0000','0000',colorsOn};...
                {5*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {5*120+1,    visStimN, LaserOn, '0000','0000',colorsOn};...
                {6*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {6*120+1,    visStimN, LaserOn, '0000','0000',colorsOn};...
                {7*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {7*120+1,    visStimN, LaserOff, '0000','0000',colorsOn};...
                {8*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {8*120+1,    visStimN, LaserOff, '0000','0000',colorsOn};...
                {9*120,[0, rand(1)*360, 0, 0], LaserOff, '0000','0000',colorsOff};...
        {9*120+1,    visStimN, LaserOff, '0000','0000',colorsOn};...
        
    ];

    