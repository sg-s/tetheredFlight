
% closedLoop.m

% Constants
global ts;

center = 0;

% Format: {time, visStim}
%          [Mode, K0, K1, K2]
visStim0 = [1, 0, 0,  center];
visStimN = [1, 0, -1, center];
LaserOn  = '0000';
LaserOff = '0000';
olf1 = '0000';
olf2 = '0000';

histogramBounds = [1,60*5];

trialStructureList = [...
        {0,    visStimN, LaserOff, '0000','0000'};...     %nb. First line is initial settingss
        {1,    visStimN, LaserOn, '0000','8001'};...
        {60*5,  visStimN, LaserOff, '0000','0000'};...
    ];

    