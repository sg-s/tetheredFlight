
% closedLoop.m

% Constants
global ts;

center = 0;

% Format: {time, visStim}
%          [Mode, K0, K1, K2]
visStim0 = [1, 0, 0,  center];
visStimN = [1, 0, -6, 0];
%visStimN = [2, 90,3,0,0,-3,0];
LaserOn  = '0000';
LaserOff = '0000';
olf1 = '0000';
olf2 = '0000';

histogramBounds = [1,120];

trialStructureList = [...
        {0,    visStimN, LaserOff, '0000','0000','0000'};...     %nb. First line is initial settingss
        {1,    visStimN, LaserOn,  '0000','0000','0000'};...
        {120,  visStimN, LaserOn, '0000','0000','0000'};...
    ];

    